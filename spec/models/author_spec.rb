require 'rails_helper'
RSpec.describe Author do
  let(:author) { FactoryBot.create :author }


  it 'should return email' do
    expect(author.email).to eq('user1@test.com')
  end

  it 'should encrypt password' do
    expect(author.encrypted_password).to_not eq('password')
  end
end