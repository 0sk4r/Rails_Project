module Api
  class PostsController < ApplicationController
    def index
      provider = PostsProvider.new(params[:key])

      render json: provider.results
    end
  end
end
