class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :price

      t.timestamps
    end
    add_index :products, :name
  end
end
