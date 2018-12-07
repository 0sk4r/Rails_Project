class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  before_action :authenticate_author!

  def new
    @vote = Vote.find_or_initialize_by(author_id: current_author.id, voting_object_id: params[:voting_object_id], voting_object_type: params[:voting_object_type])
    if @vote.vote_type == params[:vote_type].to_i
      Vote.destroy(@vote.id)
    else
      @vote.vote_type = params[:vote_type]
    end

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
    params.permit(:voting_object_type, :voting_object_id, :vote_type).merge(author_id: current_author.id)
  end
end
