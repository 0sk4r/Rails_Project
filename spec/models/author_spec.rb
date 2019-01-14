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

  it 'should pass user with no ban information' do
    expect(author.active_for_authentication?).to eq true
  end

  it 'should block banned users from authentication' do
    author.update(blocked_to: Time.now + 10.minutes)

    expect(author.active_for_authentication?).to eq false
  end

  it 'should pass users with expired ban' do
    author.update(blocked_to: Time.now - 10.minutes)

    expect(author.active_for_authentication?).to eq true
  end
end
