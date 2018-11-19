class Vote < ApplicationRecord
  validates :author_id, uniqueness: { scope: :post_id }
  belongs_to :author
  belongs_to :post

  enum selectable_vote_types: %i[upvote downvote]
end
