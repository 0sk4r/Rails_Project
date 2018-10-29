class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  before_action :authenticate_author!, only: [:new, :create]
  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @author = Author.find(@post.author_id)
  end

  def create
    @post = Post.new(
        params.require(:post).permit(:content, :title).merge(author_id: current_author.id)
    )

    flash[:notice] = if @post.save
                       'Post dodany'
                     else
                       @post.errors.full_messages.join('. ')
                     end

    redirect_to '/'
  end

  def destroy
    @post = Post.find(params[:id])

    flash[:notice] = if @post.destroy
                       'Post usunięty'
                     else
                       @post.errors.full_messages.join('. ')
                     end

    redirect_to '/'
  end
end
