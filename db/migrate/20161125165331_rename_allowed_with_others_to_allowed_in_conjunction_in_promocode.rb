class RenameAllowedWithOthersToAllowedInConjunctionInPromocode < ActiveRecord::Migration[5.0]
  def change
    rename_column :promocodes, :allowed_with_others, :allowed_in_conjunction
  end
end
