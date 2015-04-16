require "rails_helper"
describe "Guests can browse for their meal" do
  context "on the dashboard" do
    it "displays a selection of categories and garments" do
      create_list :garment, 3
      seller = create(:seller)
      Garment.first.update(seller_id: seller.id)
      Garment.second.update(seller_id: seller.id)
      Garment.third.update(seller_id: seller.id)
      visit root_path
      expect(page).to have_content("Garment 1")
      expect(page).to have_content("Garment 2")
      expect(page).to have_content("Garment 3")
    end

    it "links to categories page" do
      category = create(:category, name: "sabertooth",
                        description: "A long fanged feline for your long suffering appetite!",
                        image_path: "sabertooth_01.jpeg",
                        retired: false)

      visit category_path(category)
      expect(current_path).to eq("/categories/#{category.name}")
      expect(page).to have_content("#{category.name.capitalize}")
    end

    it "links to garments page" do
      seller = create(:seller)
      garment_test = create(:garment, name: "horacio",
                            seller_id: seller.id,
                            description: "Once the prince of wales' garment, horacio fell on hard times",
                            price: 1000,
                            retired: false,
                            image_path: "sabertooth_01.jpg")

      visit root_path
      expect(page).to have_content(garment_test.name)
      click_link_or_button(garment_test.name)
      expect(current_path).to eq(seller_garment_path(slug: seller.slug, id: garment_test.id))
      expect(page).to have_content(garment_test.name)
    end
  end

  context "on the '/categories' page" do
    it "shows a proper list of categories"do
      category_list = create_list :category, 3

      visit root_path
      click_link_or_button("categories")
      expect(current_path).to eq("/categories")
      expect(page).to have_content("#{category_list.first.name}")
      expect(page).to have_content("#{category_list[1].name}")
      expect(page).to have_content("#{category_list.last.name}")
    end

    it "links to individual categories" do
      categories = create_list :category, 3
      visit categories_path
      click_link_or_button(categories[0].name)
      expect(current_path).to eq("/categories/#{categories[0].name.gsub(" ", "%20")}")
    end
  end

  context "on the '/garments' page" do
    it "shows a proper list of garments"do
      create_list :garment, 3
      seller = create(:seller)
      Garment.first.update(seller_id: seller.id)
      Garment.second.update(seller_id: seller.id)
      Garment.third.update(seller_id: seller.id)
      visit seller_path(slug: seller.slug)
      expect(page).to have_content("Garment 4")
      expect(page).to have_content("Garment 5")
      expect(page).to have_content("Garment 6")
    end

    it "links to individual garments" do
      seller = create(:seller)
      garments = create_list :garment, 3
      Garment.first.update(seller_id: seller.id)
      garment = garments[0]
      visit seller_path(slug: seller.slug)
      click_link_or_button(garment.name)
      expect(current_path).to eq(seller_garment_path(slug: seller.slug, id: garment.id))
    end

    it "links to individual garments from categories page" do
      seller = create(:seller)
      category = Category.create(name: "category1", description: "none", retired: false)
      garment = category.garments.create(name:"random name", description: "cool cat", price: 1000, seller_id: seller.id)
      visit categories_path
      click_link_or_button("category1")
      click_link_or_button("random name")
      expect(current_path).to eq(seller_garment_path(slug: seller.slug, id: garment.id))
    end
  end
end
