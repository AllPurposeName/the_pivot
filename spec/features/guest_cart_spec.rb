require "rails_helper"
describe "guest can use a cart" do
  it "redirects through the continue button" do
    kitty = create(:garment, name: "kitty")

    visit "/garments/#{kitty.id}"
    click_link_or_button("add to cart")
    expect(current_path).to eq(cart_path)
    click_link_or_button("continue")
    expect(current_path).to eq("/categories")
  end

  it "displays multiple garments" do
    kitty = create(:garment, name: "kitty")
    visit "/garments/#{kitty.id}"
    click_link_or_button("add to cart")
    visit "/garments/#{kitty.id}"
    click_link_or_button("add to cart")
    kitty.price = (kitty.price * 2)
    expect(page).to have_content(kitty.monify)
  end

  context "has a button to" do
    it "increment by one" do
      bruno = create(:garment, name: "Bruno")
      visit "/garments/#{bruno.id}"
      click_link_or_button("add to cart")
      expect(page).to have_content(1)
      click_link_or_button("plus-#{bruno.id}")
      expect(page).to have_content(2)
    end
    it "decrement by one" do
      bronson = create(:garment, name: "Bronson")
      visit "/garments/#{bronson.id}"
      click_link_or_button("add to cart")
      expect(page).to have_content(1)
      click_link_or_button("plus-#{bronson.id}")
      expect(page).to have_content(2)
      click_link_or_button("minus-#{bronson.id}")
      expect(page).to have_content(1)
    end
    it "destroys a garment" do
      kitty = create(:garment, name: "kitty")
      visit "/garments/#{kitty.id}"
      click_link_or_button("add to cart")
      click_link_or_button("plus-#{kitty.id}")
      click_link_or_button("remove-#{kitty.id}")
      expect(page).not_to have_content("kitty")
    end

  end
end
