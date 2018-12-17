require 'rails_helper'

RSpec.describe Api::AuthorController do
  describe 'GET #email_exists' do
    subject { get :email_exists, params: { email: email } }
    let(:email) { 'test@test.com' }

    it do
      expect(subject).to be_successful
      expect(JSON.parse(subject.body)).to eq(false)
    end

    context 'when email is taken' do
      let(:user) { FactoryBot.create(:author, email: 'user1@test.com') }
      let(:email) { user.email }

      it do
        expect(subject).to be_successful
        expect(JSON.parse(subject.body)).to eq(true)
      end
    end
  end

  describe 'GET authors list' do
    subject { get :index, params: { key: nick } }
    let(:nick) { 'ab' }

    context 'when there is no authors' do
      it do
        expect(subject).to be_successful
        expect(JSON.parse(subject.body)).to eq([])
      end

      context 'when there is one matching user' do
        let!(:author1) { FactoryBot.create(:author, nick: 'abcd') }
        let!(:author2) { FactoryBot.create(:author, nick: 'cde') }

        it do
          expect(subject).to be_successful
          parsed_body = JSON.parse(subject.body)
          expect(parsed_body[0]['nick']).to eq(author1.nick)
        end

        context 'when there is two matching users' do
          let!(:author3) { FactoryBot.create(:author, nick: 'abde') }
          it do
            expect(subject).to be_successful
            parsed_body = JSON.parse(subject.body)
            expect(parsed_body[0]['nick']).to eq(author1.nick)
            expect(parsed_body[1]['nick']).to eq(author3.nick)
          end
        end
      end
    end
  end
end
