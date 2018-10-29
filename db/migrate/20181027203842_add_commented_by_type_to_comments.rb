# frozen_string_literal: true

class AddCommentedByTypeToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :commented_by_type, :string
  end
end
