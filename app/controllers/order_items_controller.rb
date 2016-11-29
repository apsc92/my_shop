class OrderItemsController < ApplicationController
  before_action :load_item, :load_order

  def destroy
    @order_item.destroy
    flash[:notice] = 'Item removed successfully'
    redirect_to root_path and return if @order.order_items.count == 0
    redirect_to edit_order_path(@order)
  end

  def update
    @order_item.quantity = params[:quantity]
    @order_item.save
    flash[:notice] = 'Item quantity updated successfully'
    render json: {success: true}
  end

  private

  def load_order
    @order = Order.find(params[:order_id])
  end

  def load_item
    @order_item = OrderItem.find(params[:id])
  end
end
