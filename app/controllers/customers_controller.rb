class CustomersController < ApplicationController
  def new
  end

  def create
    customer = Customer.find_or_create_by(email: params[:customer][:email])
    current_order.customer = customer
    current_order.save
    session[:customer_id] = customer.id
    redirect_to new_order_address_path(order_id: current_order.id)
  end
end
