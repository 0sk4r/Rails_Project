class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_commented_by

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commented_by.comments.new comment_params

    flash[:notice] = if @comment.save
                       'Komentarz dodany'
                     else
                       @comment.errors.full_messages.join('. ')
                     end
    redirect_to @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(author_id: current_user.id)
  end

  def find_commented_by
    @commented_by = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commented_by = Post.find_by_id(params[:post_id]) if params[:post_id]
  end

end