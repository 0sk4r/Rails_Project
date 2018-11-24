# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @top_post, @posts = ListPosts.run!
  end

  before_action :authenticate_author!, only: %i[new create]
  def new
    @post = Post.new
    @categories = Category.all.map { |cat| [cat.name, cat.id] }
  end

  def show
    @post = Post.find(params[:id])
    @score = score
  end

  def create
    @post = Post.new(post_params)

    @post.thumbnail.attach(params[:post][:thumbnail])

    flash[:notice] = if @post.save
                       'Post dodany'
                     else
                       @post.errors.full_messages.join('. ')
                     end

    redirect_to post_path(@post)
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

  def notify
    post_id = params[:id]
    author_id = current_author.id

    NotificationWorker.perform_in(5.minute, author_id, post_id)

    redirect_back fallback_location: '/'
  end

  def score
    votes = Vote.where(post_id: params[:id])
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

  def post_params
    params.require(:post).permit(:content, :title, :category_id).merge(author_id: current_author.id)
  end
end
