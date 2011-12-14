class CreateNotificationRestrictions < ActiveRecord::Migration
  def change
    create_table :notification_restrictions do |t|
      t.references :user
      t.float :minimumPrice
      t.float :maximumPrice

      t.timestamps
    end
    add_index :notification_restrictions, :user_id
  end
end
