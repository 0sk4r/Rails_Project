class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  before_action :authenticate_author!

  def new
    @vote = Vote.new(vote_params)
    if @vote.save
      flash[:notice] = 'Upvoted' if @vote.vote_type.zero?
      flash[:notice] = 'Downvoted' if @vote.vote_type == 1
    else
      flash[:alert] = @vote.errors.full_messages.join('. ')
    end
    redirect_back fallback_location: '/'
  end

  private

  def vote_params
    params.permit(:voting_object, :vote_type).merge(author_id: current_author.id)
  end
end
