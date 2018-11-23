FactoryBot.define do
  factory :category do
    sequence(:name) { |n| (n % 2).to_s }
  end
end
