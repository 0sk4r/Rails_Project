# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commented_by, polymorphic: true
  has_many :comments, as: :commented_by, dependent: :delete_all
  belongs_to :author

  validates_presence_of :content
end
