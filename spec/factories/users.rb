FactoryGirl.define do
  factory :user do
    first_name       "John"
    last_name        "Smith"
    sequence(:email) { |n| "johns@gmail.com".gsub("@", "-#{n}@") }
    password_digest  "supersecret"
    admin            true
  end
end
