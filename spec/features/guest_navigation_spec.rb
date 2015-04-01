require "rails_helper"
describe "Guests can browse for their meal" do
  context "on the dashboard" do
    it "displays a selection of breeds and cats" do
      create_list :cat, 3
      visit root_path
      expect(page).to have_content("READY RIGHT MEOW")
      expect(page).to have_content("Cat 1")
      expect(page).to have_content("Cat 2")
      expect(page).to have_content("Cat 3")
    end

    it "links to breeds page" do
      breed = create(:breed, name: "sabertooth",
                     description: "A long fanged feline for your long suffering appetite!",
                     image_path: "sabertooth_01.jpeg",
                     retired: false)

      visit breed_path(breed)
      expect(current_path).to eq("/breeds/#{breed.name}")

      within "#status" do
        expect(page).to have_content("Available!")
      end
      within "#breed-single" do
        expect(page).to have_content("#{breed.name.capitalize}")
        expect(page).to have_content("A long fanged feline for your long suffering appetite!")
      end
    end

    it "links to cats page" do
      cat_test = create(:cat, name: "horacio",
                              # breed: "sabertooth",
                              description: "Once the prince of wales' cat, horacio fell on hard times",
                              price: 1000,
                              retired: false,
                              image_path: "sabertooth_01.jpg")

      visit root_path
      click_link_or_button("#{cat_test.name}")

      within "#status" do
        expect(page).to have_content("Available!")
      end

      within "#cat-single" do
        expect(current_path).to eq("/cats/#{cat_test.id}")
        expect(page).to have_content("#{cat_test.name.capitalize}")
        expect(page).to have_content("Once the prince of wales' cat, horacio fell on hard times")
      end
    end
  end

  context "on the '/breeds' page" do
    it "shows a proper list of breeds"do
      breed_list = create_list :breed, 3

      visit root_path
      click_link_or_button("breeds")
      expect(current_path).to eq("/breeds")
      expect(page).to have_content("#{breed_list.first.name}")
      expect(page).to have_content("#{breed_list[1].name}")
      expect(page).to have_content("#{breed_list.last.name}")
    end

    it "links to individual breeds" do
      breeds = create_list :breed, 3
      # binding.pry
      visit breeds_path
      click_link_or_button(breeds[0].name)
      expect(current_path).to eq("/breeds/#{breeds[0].name.gsub(" ", "%20")}")
    end
  end

  context "on the '/cats' page" do
    it "shows a proper list of cats"do
      create_list :cat, 3
      visit cats_path
      expect(page).to have_content("Cat 4")
      expect(page).to have_content("Cat 5")
      expect(page).to have_content("Cat 6")
    end

    it "links to individual cats" do
      cats = create_list :cat, 3
      cat = cats[0]
      visit cats_path
      click_link_or_button(cat.name)
      expect(current_path).to eq("/cats/#{cat.id}")
    end

    it "links to individual cats from breeds page" do
      breed = Breed.create(name: "breed1", description: "none", retired: false)
      cat = breed.cats.create(name:"random name", description: "cool cat", price: 1000)
      visit root_path
      click_link_or_button("breed1")
      click_link_or_button("random name")
      expect(current_path).to eq("/cats/#{cat.id}")
    end
  end
end
