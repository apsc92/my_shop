class AddressesController < ApplicationController
  before_action :load_order

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.order = @order
    if @address.save
      flash[:notice] = 'Delivery address added successfully'
      redirect_to new_customer_credit_card_path(customer_id: current_user.id)
    else
      render 'new'
    end
  end

  private

  def load_order
    @order = Order.find(params[:order_id])
  end

  def address_params
    params.require(:address).permit(:city, :state, :street_address)
  end
end
