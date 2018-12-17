class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.datetime :read_at

      t.integer :notification_object_id
      t.string :notification_object_type

      t.timestamps
    end
  end
end
