FactoryGirl.define do
  factory :friendship_request do
    user
    association :friend, factory: :user
    status 0
  end
end
