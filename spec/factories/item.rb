FactoryGirl.define do

  factory :item do
    sequence(:name) { |n| "Cat #{n}"}
    price 3000
    retired false
    image_path "MyText"
    description "MyText"
  end

end
