require 'rails_helper'
RSpec.describe Post do
  let!(:post) { FactoryBot.create :post }

  subject { post }
  it 'has author' do
    is_expected.to belong_to(:author)
  end

  it 'has content' do
    is_expected.to validate_presence_of(:content)
  end

  it 'has title' do
    is_expected.to validate_presence_of(:title)
  end

  it 'has many votes' do
    is_expected.to have_many(:votes)
  end
  context 'post with one positive vote' do
    let!(:author) { FactoryBot.create(:author, email: 'user114@test.com') }
    let!(:vote) { Vote.create(author_id: author.id, voting_object_id: post.id, voting_object_type: post.class, vote_type: 0) }

    subject { post.score }

    it {
      is_expected.to eq(1)
    }

    context 'post with one negative and one positive vote' do
      let!(:author2) { FactoryBot.create(:author, email: 'user123@test.com') }
      let!(:vote2) { Vote.create(author_id: author2.id, voting_object_id: post.id, voting_object_type: post.class, vote_type: 1) }

      it {
        is_expected.to eq(0)
      }
    end
  end
end
