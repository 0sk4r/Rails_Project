class AddVotingObjectTypeToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :voting_object_type, :integer
  end
end
