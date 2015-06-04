FactoryGirl.define do
  factory :friendship_request do
    user
    association :friend, factory: :user
  end
end
