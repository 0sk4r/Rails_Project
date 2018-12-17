class Notification < ApplicationRecord
  belongs_to :recipient, class_name: 'Author'
  belongs_to :sender, class_name: 'Author'

  scope :unread, -> { where(read_at: nil) }

  belongs_to :notification_object, polymorphic: true
end
