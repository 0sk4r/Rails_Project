class Comment < ApplicationRecord
  belongs_to :commented_by, polymorphic: true
  has_many :comments, as: :commented_by
  belongs_to :author
end
