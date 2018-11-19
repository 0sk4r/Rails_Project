require 'rails_helper'

RSpec.describe PostsController do
  let(:post) { FactoryBot.create :post }

  describe 'GET index' do
    it 'response with :index template' do
      get :index
      expect(response).to render_template 'index'
    end

    it 'top post' do
      get :index
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe 'GET show' do

    it 'post content' do
      get :show, :params => {:id => post.id}
      expect(assigns(:post)).to eq(post)
    end
  end
end
