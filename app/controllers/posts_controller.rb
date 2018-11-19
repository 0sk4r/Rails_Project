# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    # top_post_id = Post.joins(:votes).group(:post_id).count.sort.to_h
    top_post_id = Post.joins(:votes).group(:post_id, :id).select('posts.id, count(post_id) as count').order('count asc').last
    @top_post = if !top_post_id.nil?
                  Post.find(top_post_id.id)
                else
                  Post.last
                end
    @posts = Post.where.not(id: top_post_id)

  end

  before_action :authenticate_author!, only: %i[new create]
  def new
    @post = Post.new
    @categories = Category.all.map{ |cat| [cat.name, cat.id]}
  end

  def show
    @post = Post.find(params[:id])
    @score = score
  end

  def create
    @post = Post.new(
      params.require(:post).permit(:content, :title, :category_id).merge(author_id: current_author.id)
    )

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

    NotificationWorker.perform_in(5.minute,author_id, post_id)

    redirect_back fallback_location: '/'
  end

  def score
    votes = Vote.where(post_id: params[:id])
    result = 0
    votes.each do |vote|
      if vote.vote_type == 0
        result += 1
      else
        result -= 1
      end
    end
    result
  end

end
