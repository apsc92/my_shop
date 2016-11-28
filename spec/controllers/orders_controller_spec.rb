require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'POST apply_promocode' do
    it 'apply percentage promocode if no promo is already applied'
    it 'do not apply if promocode is not allowed in conjunction'
    it 'do not apply if after applying promocode total cost is negative'
  end

end
