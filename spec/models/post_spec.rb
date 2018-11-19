require 'rails_helper'
RSpec.describe Post do
  let(:post) { FactoryBot.create :post }

  subject {post}
  it 'has author' do
    is_expected.to belong_to(:author)
  end

  it 'has content' do
    is_expected.to validate_presence_of(:content)
  end

  it 'has title' do
    is_expected.to validate_presence_of(:title)
  end
end