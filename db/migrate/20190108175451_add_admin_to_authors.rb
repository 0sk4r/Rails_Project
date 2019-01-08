class AddAdminToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :admin, :boolean, default: false
  end
end
