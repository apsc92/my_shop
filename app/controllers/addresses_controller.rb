class AddressesController < ApplicationController

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.order = current_order
    if @address.save
      flash[:notice] = 'Delivery address added successfully'
      redirect_to new_customer_credit_card_path(customer_id: current_user.id)
    else
      render 'new'
    end
  end

  private

  def address_params
    params.require(:address).permit(:city, :state, :street_address)
  end
end
