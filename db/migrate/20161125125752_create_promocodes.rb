class CreatePromocodes < ActiveRecord::Migration[5.0]
  def change
    create_table :promocodes do |t|
      t.string :name
      t.float :percentage
      t.boolean :allowed_with_others
      t.float :flat_discount
      t.string :type
      t.timestamps
    end
  end
end
