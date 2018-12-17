module Api
  class NotificationsController < ApplicationController
    def count
      render json: Notification.where(recipient: current_author.id).unread.count
    end
  end
end
