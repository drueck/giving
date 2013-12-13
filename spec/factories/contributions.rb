FactoryGirl.define do
  factory :contribution do
    contributor
    amount "9.99"
    date Time.now

    factory :deleted_contribution do
      status "Deleted"
    end
  end
end
