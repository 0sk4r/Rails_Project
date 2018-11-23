# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author
  belongs_to :category

  has_many :comments, as: :commented_by, dependent: :delete_all
  has_one_attached :thumbnail
  has_many :votes, dependent: :delete_all
  has_many :voters, through: :votes

  validates_presence_of :content
  validates_presence_of :title
end
