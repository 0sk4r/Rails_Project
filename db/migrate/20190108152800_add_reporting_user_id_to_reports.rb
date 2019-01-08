class AddReportingUserIdToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :reporting_user_id, :integer
  end
end
