module Api

  class AuthorController < ApplicationController
    def index
      provider = AuthorsProvider.new(params[:key])

      render json: provider.results
    end
  end
end