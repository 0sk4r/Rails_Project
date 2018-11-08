class VotesController < ApplicationController

  before_action :authenticate_author!

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      flash[:notice] = 'Voted for post'
    else
      flash[:notice] = 'Something went wrong'
    end
    redirect_to post_path(@post)
  end

  private

  def vote_params
    params.require(:vote).permit(:author_id, :post_id, :vote_type)
  end

end