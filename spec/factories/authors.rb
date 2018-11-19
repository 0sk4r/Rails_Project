FactoryBot.define do
  factory :author do
    sequence(:email) { |n| "user#{n}@test.com" }
    nick {Faker::Internet.username}
    password { 'password' }
  end
end