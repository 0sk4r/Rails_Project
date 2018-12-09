module Api
  class AuthorController < ApplicationController
    def index
      provider = AuthorsProvider.new(params[:key])

      render json: provider.results
    end

    def email_exists
      render json: Author.where(email: params[:email]).exists?
    end
  end
end
