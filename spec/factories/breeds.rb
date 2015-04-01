FactoryGirl.define do

  factory :breed do
    sequence(:name) { |n| "Breed #{n}"}
    image_path "MyText"
    retired false
    description "MyText2"
  end

end
