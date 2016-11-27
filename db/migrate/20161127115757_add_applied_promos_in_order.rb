class AddAppliedPromosInOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :applied_promo_ids, :string, array: true, default: []
  end
end
