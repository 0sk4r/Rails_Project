# frozen_string_literal: true

class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
    @posts = @author.posts.all
    @votes = @author.votes.all
  end

  def ban
    time = params[:authors][:time].to_i

    author = Author.find(params[:authors][:author])
    author.blocked_to = Time.now + time.minutes
    author.save!
  end
end
