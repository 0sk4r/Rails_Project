require 'rails_helper'
RSpec.describe Vote do
  let(:vote) { FactoryBot.create :vote }

  subject { vote }

  it 'belongs to author' do
    is_expected.to belong_to(:author)
  end

  it 'belongs to post' do
    is_expected.to belong_to(:post)
  end
end