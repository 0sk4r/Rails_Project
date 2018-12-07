# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commented_by, polymorphic: true
  has_many :comments, as: :commented_by, dependent: :delete_all
  belongs_to :author
  has_many :votes, as: :voting_object, dependent: :delete_all
  validates_presence_of :content

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
