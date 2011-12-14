class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.references :user
      t.references :property

      t.timestamps
    end
    add_index :interests, :user_id
    add_index :interests, :property_id
  end
end
