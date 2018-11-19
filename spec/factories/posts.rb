FactoryBot.define do
  factory :post do
    title { Faker::BackToTheFuture.character }
    content { Faker::BackToTheFuture.quote }
    association :author
    association :category
  end
end