class OrdersController < ApplicationController

  def checkout
    @order = current_order
    @order_items = current_order.order_items
    @applied_promos = Promocode.where(id: current_order.applied_promo_ids)
    @customer = current_order.customer
    @credit_card = CreditCard.new(customer: @customer)
  end

  def apply_promocode
    promocode = Promocode.find_by_name(params[:promocode])
    if promocode # Check if promocode is correct
      if promocode_applicable?
        current_order.applied_promo_ids << promocode.id
        current_order.save
      end
    else
      flash[:alert] = 'No such promocode exist'
    end
    redirect_to checkout_path
  end

  def confirm_order
    begin
      current_order.address = Address.create(order_params[:address])
      customer_params = order_params[:customer]
      existing_customer = Customer.where(email: customer_params[:email]).first
      if existing_customer
        current_order.customer = existing_customer
        current_order.save
      end
      customer = current_order.customer
      customer.credit_card = CreditCard.create(customer_params[:credit_card])
      customer.update_attributes(name: customer_params[:name], email: customer_params[:email])
      current_order.confirm
      session[:order_id] = nil
      flash[:notice] = 'Order successfully placed and will be delivered your address'
      redirect_to root_path
    rescue
      flash[:alert] = 'Problem encountered while placing order.Please retry'
      redirect_to checkout_path
    end
  end

  def remove_promocode
    current_order.applied_promo_ids.delete(params[:promocode_id])
    current_order.save
    flash[:notice] = 'Promocode removed successfully'
    redirect_to checkout_path
  end

  private

  def promocode_applicable?
    # Is promocode already applied
    # Is promocode allowed in conjunction with other codes
    # If discount is flat then total cost should be above 0 after applying
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

  def order_params
    params.require(:order).permit(customer:  [:name, :email, credit_card: [:owner_name, :number]],
      address: [:street_address, :city])
  end
end
