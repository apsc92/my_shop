class OrderItemsController < ApplicationController

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    flash[:notice] = 'Item removed successfully'
    redirect_to root_path and return if current_order.order_items.count == 0
    redirect_to checkout_path
  end
end
