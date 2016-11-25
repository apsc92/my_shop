class CreateBundleDiscounts < ActiveRecord::Migration[5.0]
  def change
    create_table :bundle_discounts do |t|
      t.integer :quantity_to_be_purchased
      t.integer :targeted_product_id
      t.float :price_after_discount
      t.timestamps
    end
  end
end
