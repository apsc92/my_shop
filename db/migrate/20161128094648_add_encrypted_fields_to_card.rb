class AddEncryptedFieldsToCard < ActiveRecord::Migration[5.0]
  def change
    rename_column :credit_cards, :number, :encrypted_number
    rename_column :credit_cards, :owner_name, :encrypted_owner_name
  end
end
