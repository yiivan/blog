FactoryGirl.define do
  factory :post do
    title "Hello World"
    body "Hello World!"
    association :category, factory: :category
  end
end
