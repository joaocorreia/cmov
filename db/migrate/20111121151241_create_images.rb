class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :property
      t.text :url

      t.timestamps
    end
    add_index :images, :property_id
  end
end
