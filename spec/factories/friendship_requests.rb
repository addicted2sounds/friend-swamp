FactoryGirl.define do
  factory :friendship_request do
    user
    association :friend, factory: :user
    status :pending
  end
end
