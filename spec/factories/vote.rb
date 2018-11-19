FactoryBot.define do
  factory :vote do
    vote_type { 0 }
    association :author
    association :post
  end
end