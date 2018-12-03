class Vote < ApplicationRecord

  validates :author_id, uniqueness: { scope: [:voting_object_id, :voting_object_type] }
  belongs_to :author
  belongs_to :voting_object, polymorphic: true

  enum selectable_vote_types: %i[upvote downvote]
end
