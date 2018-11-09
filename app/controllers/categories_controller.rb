class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new comment_params

    flash[:notice] = if @category.save
                       'Kategoria dodana'
                     else
                       @category.errors.full_messages.join('. ')
                     end

    redirect_to '/'

  end

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts.all
  end

  def index
    @categories = Category.all
  end
end
private

def comment_params
  params.require(:category).permit(:name)
end