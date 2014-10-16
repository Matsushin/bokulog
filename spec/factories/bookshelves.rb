FactoryGirl.define do
  factory :bookshelf do
    sequence(:id)
    sequence(:user_id)
  end
end