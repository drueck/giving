FactoryGirl.define do
  factory :contributor do
    name { |n| "Contributor #{n}" }
  end
end
