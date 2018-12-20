class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  before_action :authenticate_author!

  def new
    @vote = Vote.find_or_initialize_by(author_id: current_author.id, voting_object_id: params[:voting_object_id], voting_object_type: params[:voting_object_type])
    manage_vote
    redirect_back fallback_location: '/'
  end

  private

  def vote_params
    params.permit(:voting_object_type, :voting_object_id, :vote_type).merge(author_id: current_author.id)
  end

  def delete_vote
    Vote.destroy(@vote.id)
    flash[:notice] = 'Removed' if @vote.save
  end

  def update_vote
    @vote.vote_type = params[:vote_type]
    if @vote.save
      flash[:notice] = 'Upvoted' if @vote.vote_type.zero?
      flash[:notice] = 'Downvoted' if @vote.vote_type == 1
    else
      flash[:alert] = @vote.errors.full_messages.join('. ')
    end
  end

  def manage_vote
    if @vote.vote_type == params[:vote_type].to_i
      delete_vote
    else
      update_vote
    end
  end
end
