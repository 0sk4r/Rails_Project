class Post < ApplicationRecord
  belongs_to :author
  has_many :comments, as: :commented_by, dependent: :delete_all
end
