class CreditCardsController < ApplicationController

  def new
    @credit_card = CreditCard.new
  end

  def create
    @credit_card = CreditCard.new(credit_card_params)
    @credit_card.customer = current_user
    if @credit_card.save
      current_order.confirm
      session[:order_id] = nil
      flash[:notice] = 'Order successfully placed and will be delivered your address'
      redirect_to order_path(current_order.id)
    else
      render 'new'
    end
  end

  private

  def credit_card_params
    params.require(:credit_card).permit(:owner_name, :number)
  end
end
