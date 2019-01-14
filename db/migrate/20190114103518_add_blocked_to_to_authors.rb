class AddBlockedToToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :blocked_to, :timestamp
  end
end
