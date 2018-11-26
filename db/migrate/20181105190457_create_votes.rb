class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :author, foreign_key: true
      t.references :voting_object, index: true, polymorphic: true
      t.timestamps
    end
    add_foreign_key :votes, :votables
  end
end
