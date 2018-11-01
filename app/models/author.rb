# frozen_string_literal: true

class Author < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts

  after_create :send_welcome_email
  after_update :send_notify_email

  private

  def send_welcome_email
    AuthorMailer.welcome_author(self).deliver
  end

  def send_notify_email
    AuthorMailer.notify_author(self).deliver
  end

end
