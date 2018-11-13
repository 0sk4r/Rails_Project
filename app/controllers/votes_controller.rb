class VotesController < ApplicationController

  def index
    @votes = Vote.all
  end

  before_action :authenticate_author!

  def new
    @vote = Vote.new(vote_params)
    if @vote.save
      if @vote.vote_type == 0
        flash[:notice] = 'Upvoted'
      end
      if @vote.vote_type == 1
        flash[:notice] = 'Downvoted'
      end
    else
      flash[:alert] = @vote.errors.full_messages.join('. ')
    end
    redirect_back fallback_location: '/'
  end

  private

  def vote_params
    params.permit(:post_id, :vote_type).merge(author_id: current_author.id)
  end

end