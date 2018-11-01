# frozen_string_literal: true

class Author < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts

  after_create :send_email
  def send_email
    WelcomeMailer.welcome_author(self).deliver
  end
end
