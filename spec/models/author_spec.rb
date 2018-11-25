require 'rails_helper'
RSpec.describe Author do
  let(:author) { FactoryBot.create(:author, email: 'user1@test.com') }

  it 'should return email' do
    expect(author.email).to eq('user1@test.com')
  end

  it 'should encrypt password' do
    expect(author.encrypted_password).to_not eq('password')
  end

  it 'should notify after password update' do
    author.update(password: 'test')

    expect(ActionMailer::Base.deliveries.last.to).to eq([author.email])

  end
end
