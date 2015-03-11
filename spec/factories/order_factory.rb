FactoryGirl.define do
  factory :order do
    created_at "created_at"
    updated_at "updated_at"
    status "Paid"
    association :author, factory: :user, id: 1
  end
end
