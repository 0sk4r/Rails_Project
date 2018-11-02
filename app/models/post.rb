# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author
  has_many :comments, as: :commented_by, dependent: :delete_all
  has_one_attached :thumbnail

  validates_presence_of :content
  validates_presence_of :title
end
