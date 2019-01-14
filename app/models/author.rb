# frozen_string_literal: true

class Author < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :votes
  has_many :liked_posts, through: :votes
  has_many :notifications, foreign_key: :recipient_id
  has_many :reports
  after_create :send_welcome_email
  after_update :send_notify_email

  def account_banned?
    blocked_to.nil? || blocked_to < Time.now
  end

  def active_for_authentication?
    super && account_banned?
  end

  def inactive_message
    account_banned? ? super : :locked
  end

  private

  def send_welcome_email
    AuthorMailer.welcome_author(self).deliver
  end

  def send_notify_email
    AuthorMailer.notify_author(self).deliver
  end
end
