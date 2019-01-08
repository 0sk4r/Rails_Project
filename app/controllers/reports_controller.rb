class ReportsController < ApplicationController
  before_action :check_admin, only: [:index]

  def index
    @reports = Report.all
  end

  def create
    set_post

    @report = @post.reports.new(reporting_user: current_author)
    flash[:notice] = if @report.save
                       'Reported'
                     else
                       report.errors.full_messages.join('. ')
                     end
    redirect_to @post
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def check_admin
    redirect_to '/', alert: "Don't have permission!" unless current_author.admin
  end
end
