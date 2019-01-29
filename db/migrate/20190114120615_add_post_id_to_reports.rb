class AddPostIdToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :post_id, :integer
  end
end
