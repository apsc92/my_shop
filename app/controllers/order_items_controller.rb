class OrderItemsController < ApplicationController
  before_action :load_item

  def destroy
    @order_item.destroy
    flash[:notice] = 'Item removed successfully'
    redirect_to root_path and return if current_order.order_items.count == 0
    redirect_to checkout_path
  end

  def update
    @order_item.quantity = params[:quantity]
    @order_item.save
    render json: {success: true}
  end

  private

  def load_item
    @order_item = OrderItem.find(params[:id])
  end
end
