class SetDefaultValuesForPromoType < ActiveRecord::Migration[5.0]
  def change
    change_column :promocodes, :promo_type, :string, :default => 'percentage'
  end
end
