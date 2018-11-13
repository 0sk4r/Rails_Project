class Vote < ApplicationRecord
  belongs_to :author
  belongs_to :post

  enum selectable_vote_types: [ :upvote, :downvote ]
end
