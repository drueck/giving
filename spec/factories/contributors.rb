FactoryGirl.define do
  factory :contributor do
    name { |n| "Contributor #{n}" }

    factory :deleted_contributor do
      status "Deleted"
    end
  end
end
