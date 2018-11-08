class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :author, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
