# frozen_string_literal: true

class AddCommentedByIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :commented_by_id, :integer
  end
end
