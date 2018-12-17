# frozen_string_literal: true

class Comment < ApplicationRecord
  after_save :notify_users

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

  def mentions
    content.scan(/\@(\w+)/).flatten
  end

  def notify_users
    mentions = self.mentions

    mentions.each do |author_nick|
      author = Author.find_by(nick: author_nick)
      author.notifications.new(sender_id: self.author.id, notification_object: self).save unless author.nil?
    end
  end
end
