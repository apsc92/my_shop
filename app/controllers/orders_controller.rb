class OrdersController < ApplicationController

  def checkout
    @order_items = current_order.order_items
    @applied_promos = Promocode.where(id: current_order.applied_promo_ids)
  end

  def apply_promocode
    promocode = Promocode.find_by_name(params[:promocode])
    if promocode # Check if promocode is correct
      if is_promocode_applicable?
        current_order.applied_promo_ids << promocode.id
        current_order.save
      end
    else
      flash[:alert] = 'No such promocode exist'
    end
    redirect_to checkout_path
  end


  def remove_promocode
    current_order.applied_promo_ids.delete(params[:promocode_id])
    current_order.save
    flash[:notice] = 'Promocode removed successfully'
    redirect_to checkout_path
  end

  private

  def is_promocode_applicable?
    promocode_applicable = true
    if current_order.applied_promo_ids.present?
      applied_promos = Promocode.where(id: current_order.applied_promo_ids)
      if applied_promo_ids.include? promocode.id
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
end
