require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'POST apply_promocode' do
    before(:all) do
      @promocode = create(:promocode)
      @order_item = create(:order_item)
      @order = @order_item.order
    end

    it 'apply percentage promocode if no promo is already applied' do
      post :apply_promocode, {promocode: @promocode.name, id: @order.id}
      @order.reload
      expect(@order.applied_promo_ids).to include(@promocode.id.to_s)
    end

    it 'do not apply if promocode is not allowed in conjunction' do
      post :apply_promocode, {promocode: @promocode.name, id: @order.id}
      @promocode = create(:promocode, name: '5%OFF', allowed_in_conjunction: false)
      expect(@order.reload.applied_promo_ids).not_to include(@promocode.id.to_s)
    end

    it 'do not apply if after applying promocode total cost is zero or negative' do
      post :apply_promocode, {promocode: @promocode.name, id: @order.id}
      @promocode = create(:promocode, name: 'flatpromo', flat_discount: 500)
      expect(@order.reload.applied_promo_ids).not_to include(@promocode.id.to_s)
    end
  end
end
