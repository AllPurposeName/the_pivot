FactoryGirl.define do

  factory :garment do
    sequence(:name) { |n| "Garment #{n}"}
    price 3000
    retired false
    image_path "MyText"
    description "MyText"
  end

end
