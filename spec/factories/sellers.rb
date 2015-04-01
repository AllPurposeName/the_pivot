FactoryGirl.define do
  factory :seller do
    sequence(:store_name) {|n| "Store #{n}"}
  end
end
