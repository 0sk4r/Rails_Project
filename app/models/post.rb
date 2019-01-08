# frozen_string_literal: true

class Post < ApplicationRecord
  after_save :notify_users

  belongs_to :author
  belongs_to :category

  has_many :comments, as: :commented_by, dependent: :delete_all
  has_one_attached :thumbnail
  has_many :votes, as: :voting_object, dependent: :delete_all
  has_many :reports
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
