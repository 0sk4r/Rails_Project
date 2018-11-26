FactoryBot.define do
  factory :vote do
    vote_type { 0 }
    association :author
    association :voting_object, factory: :post
  end
end
