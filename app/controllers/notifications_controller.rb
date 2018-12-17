class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(recipient: current_author.id).unread
  end

  def mark_read
    @notifications = Notification.where(recipient: current_author.id).unread

    @notifications.each do |notification|
      notification.read_at = Time.now
      notification.save
    end

    redirect_back fallback_location: '/'
  end
end
