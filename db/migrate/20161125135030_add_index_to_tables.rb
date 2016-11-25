class AddIndexToTables < ActiveRecord::Migration[5.0]
  def change
    add_index :bundle_discounts, :targeted_product_id
    add_index :order_items, :order_id
    add_index :credit_cards, :customer_id
  end
end
