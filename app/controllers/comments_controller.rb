# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_author!

  def new
    @comment = Comment.new
  end

  def create
    @comment = find_commented_by.comments.new comment_params

    flash[:notice] = if @comment.save
                       'Komentarz dodany'
                     else
                       @comment.errors.full_messages.join('. ')
                     end
    redirect_back fallback_location: '/'
  end

  def destroy
    comment = Comment.find(params[:id])

    flash[:notice] = if comment.destroy
                       'Komentarz usunięty'
                     else
                       comment.errors.full_messages.join('. ')
                     end
    redirect_back fallback_location: '/'
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(author_id: current_author.id)
  end

  def find_commented_by
    return Comment.find_by_id(params[:comment_id]) if params[:comment_id]

    Post.find_by_id(params[:post_id]) if params[:post_id]
  end
end
