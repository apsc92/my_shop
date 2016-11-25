class RenameTypeToPromoTypeInPromocode < ActiveRecord::Migration[5.0]
  def change
    rename_column :promocodes, :type, :promo_type
  end
end
