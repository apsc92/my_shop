require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  describe 'removing a item from order' do
    before(:all) do
      @order = create(:order)
      @order_item = create(:order_item, order: @order)
    end

    it 'should remove item and redirect to home page if single item is there' do
      delete :destroy, {id: @order_item.id, order_id: @order.id}
      expect(@order.reload.order_items.count).to eq(0)
      response.should redirect_to root_path
    end

    it 'should remove item and redirect to order edit page if more than one item is there' do
      @order_item2 = create(:order_item, order: @order)
      delete :destroy, {id: @order_item.id, order_id: @order.id}
      expect(@order.reload.order_items.count).to eq(1)
      response.should redirect_to edit_order_path(@order)
    end
  end


  describe 'updating quantity of a item in order' do
    before(:all) do
      @order = create(:order)
      @order_item = create(:order_item, order: @order, quantity: 3)
    end

    it 'should remove item and redirect to home page if single item is there' do
      put :update, {id: @order_item.id, order_id: @order.id, quantity: 2}
      expect(@order_item.reload.quantity).to eq(2)
    end
  end
end
