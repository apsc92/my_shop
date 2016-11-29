class OrdersController < ApplicationController
  before_action :load_order_and_items, only: [:show, :edit, :apply_promocode]

  def show
  end

  def edit
    @bundle_discounts = BundleDiscount.all
    @applied_promos = Promocode.where(id: @order.applied_promo_ids)
  end

  def apply_promocode
    promocode = Promocode.find_by_name(params[:promocode])
    if promocode # Check if promocode is correct
      if promocode_applicable?(promocode)
        @order.applied_promo_ids << promocode.id
        @order.save
      end
    else
      flash[:alert] = 'No such promocode exists'
    end
    redirect_to edit_order_path(@order)
  end


  def remove_promocode
    current_order.applied_promo_ids.delete(params[:promocode_id])
    current_order.save
    flash[:notice] = 'Promocode removed successfully'
    redirect_to edit_order_path(current_order)
  end

  private

  def promocode_applicable?(promocode)
    # Is promocode already applied
    # Is promocode allowed in conjunction with other codes
    # If discount is flat then total cost should be above 0 after applying
    promocode_applicable = true
    if current_order.applied_promo_ids.present?
      applied_promos = Promocode.where(id: current_order.applied_promo_ids)
      if current_order.applied_promo_ids.include? promocode.id
        flash[:alert] = 'Promocode already applied'
        promocode_applicable = false
      # Check promocode can be applied in conjunction
      elsif !applied_promos.first.allowed_in_conjunction || !promocode.allowed_in_conjunction
        flash[:alert] = 'Promocode cannot be applied'
        promocode_applicable = false
      elsif promocode.promo_type == 'flat' && current_order.total_cost - promocode.flat_discount <= 0
        flash[:alert] = 'Promocode cannot be applied'
      end
    end
    promocode_applicable
  end

  def order_params
    params.require(:order).permit(customer:  [:name, :email, credit_card: [:owner_name, :number]],
      address: [:street_address, :city])
  end

  def load_order_and_items
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end
end
