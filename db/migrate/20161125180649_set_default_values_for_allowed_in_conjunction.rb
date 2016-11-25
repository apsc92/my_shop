class SetDefaultValuesForAllowedInConjunction < ActiveRecord::Migration[5.0]
  def change
    change_column :promocodes, :allowed_in_conjunction, :boolean, :default => true
  end
end
