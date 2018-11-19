# frozen_string_literal: true

class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
    @posts = @author.posts.all
    @votes = @author.votes.all
  end
end
