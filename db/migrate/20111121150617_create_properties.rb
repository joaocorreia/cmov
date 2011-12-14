class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.float :price
      t.string :address
      t.string :type
      t.string :city
      t.string :country
      t.text :description

      t.timestamps
    end
  end
end
