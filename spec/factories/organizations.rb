# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    name "An Organization"
    address "1234 Main St"
    city "Anytown"
    state "ST"
    zip "12345"
    phone "555-555-5555"
  end
end
