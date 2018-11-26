require 'rails_helper'

RSpec.describe ListPosts do
  describe 'interactor' do
    context 'no posts' do
      it {
        top_post, post = ListPosts.run!
        expect(top_post).to eq(nil)
        expect(post.last).to eq(nil)
      }
    end

    context 'only one post' do
      let!(:post1) { FactoryBot.create :post }

      it {
        top_post, post = ListPosts.run!
        expect(top_post).to eq(post1)
        expect(post.last).to eq(nil)
      }

      context 'posts without votes' do
        let!(:post2) { FactoryBot.create :post }

        it {
          top_post, post = ListPosts.run!
          expect(top_post).to eq(post2)
          expect(post.last).to eq(post1)
        }

        context 'post with vote' do
          let!(:author) { FactoryBot.create(:author, email: 'user11@test.com') }
          let!(:vote) { Vote.create(author_id: author.id, post_id: post1.id) }

          it {
            top_post, post = ListPosts.run!
            expect(top_post).to eq(post1)
            expect(post.last).to eq(post2)
          }
        end
      end
    end
  end
end
