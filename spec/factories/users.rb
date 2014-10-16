FactoryGirl.define do
  factory :user do
    sequence(:id)
    sequence(:email) { |n| "test#{n}@example.com" }
    password 'testtest'
    sequence(:username) { |n| "test#{n}" }
    sequence(:uid) { |n| "uid#{n}"}
    provider 'twitter'
  end
end