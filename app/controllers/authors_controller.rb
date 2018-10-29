class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
    @posts = @author.posts.all
  end
end