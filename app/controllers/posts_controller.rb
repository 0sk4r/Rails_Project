# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @top_post, @posts = ListPosts.run!
    @posts = @posts.page(params[:page]).per(10)
  end

  before_action :authenticate_author!, only: %i[new create]
  def new
    @post = Post.new
    @categories = Category.all.map { |cat| [cat.name, cat.id] }
  end

  def show
    @post = Post.find(params[:id])
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

  def delete_content
    post = Post.find(params[:id])
    post.update_attribute(:content, 'Delete by moderator')
    post.save

    redirect_to reports_path
  end

  def post_params
    params.require(:post).permit(:content, :title, :category_id).merge(author_id: current_author.id)
  end
end
