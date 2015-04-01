FactoryGirl.define do
  factory :seller do
    sequence(:slug) {|n| "slug_#{n}"}
  end

end
