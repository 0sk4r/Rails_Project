# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author
  belongs_to :category

  has_many :comments, as: :commented_by, dependent: :delete_all
  has_one_attached :thumbnail
  has_many :votes, as: :voting_object, dependent: :delete_all
  # has_many :voters, through: :votes

  validates_presence_of :content
  validates_presence_of :title

  def score
    votes = self.votes
    result = 0
    votes.each do |vote|
      if vote.vote_type.zero?
        result += 1
      else
        result -= 1
      end
    end
    result
  end
end
