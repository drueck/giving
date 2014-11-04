FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    password "longersecret"
    password_confirmation "longersecret"
    user_type User::STANDARD
  end
end
