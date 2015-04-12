require "rails_helper"

RSpec.describe Garment, type: :model do
  context "must" do

    context "have a name" do
      it "exists" do
        expect(build(:garment, name: "Snowball")).to be_valid
      end

      it "must not be blank" do
        expect(build(:garment, name: "")).to_not be_valid
      end

      it "is 2 to 32 characters long" do
        short_name = build(:garment, name: "A")
        long_name = build(:garment, name: "123456789asdfghzxcvnmfdsasdfaddds")
        expect(short_name).to_not be_valid
        expect(long_name).to_not be_valid
      end

      it "must be unique" do
        garment1 = create(:garment, name: "Abe")
        garment2 = build(:garment, name: "Abe")
        expect(garment1).to be_valid
        expect(garment2).to_not be_valid
      end
    end

    context "have a description" do
      it "exists" do
        expect(build(:garment, description: "super awesome garment")).to be_valid
      end

      it "that must not be blank" do
        expect(build(:garment, description: "")).to_not be_valid
      end
    end

    context "have a valid price" do
      it "exists" do
        expect(build(:garment, price: "1000")).to be_valid
      end

      it "that must not be blank" do
        expect(build(:garment, price: "")).to_not be_valid
      end
    end

    context "have an image path" do
      it "exists" do
        expect(build(:garment, image_path: "sabertooth_01.jpeg")).to be_valid
      end
    end

    context "belongs to a category" do
      it "exists" do
        category = create(:category, name: "sabertooth")
        feline = category.garments.create(name: "SnowballIV",
                                   price: 1000,
                                   retired: false,
                                   image_path: "image.jpg",
                                   description: "some description")
        expect(feline.categories.first.name).to eq("sabertooth")
      end
    end
  end
end
