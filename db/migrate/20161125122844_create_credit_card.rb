class CreateCreditCard < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.string :owner_name
      t.integer :customer_id
      t.integer :number
      t.timestamps
    end
  end
end
