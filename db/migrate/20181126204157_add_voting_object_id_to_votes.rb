class AddVotingObjectIdToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :voting_object_id, :integer
  end
end
