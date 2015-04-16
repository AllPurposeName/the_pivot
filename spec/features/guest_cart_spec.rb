require "rails_helper"
describe "guest can use a cart" do
  before :each do
    create(:seller)
  end
  context "with a seller" do
    it "displays multiple garments" do
      kitty = create(:garment, name: "kitty", seller_id: Seller.last.id)
      visit "/#{kitty.seller.slug}/garments/#{kitty.id}"
      click_link_or_button("add to cart")
      visit "/#{kitty.seller.slug}/garments/#{kitty.id}"
      click_link_or_button("add to cart")
      kitty.price = (kitty.price * 2)
      expect(page).to have_content(kitty.monify)
    end

    context "has a button to" do
      it "increment by one" do
        bruno = create(:garment, name: "Bruno", seller_id: Seller.last.id)
        visit "/#{bruno.seller.slug}/garments/#{bruno.id}"
        click_link_or_button("add to cart")
        expect(page).to have_content(1)
        click_link_or_button("plus-#{bruno.id}")
        expect(page).to have_content(2)
      end
      it "decrement by one" do
        bronson = create(:garment, name: "Bronson", seller_id: Seller.last.id)
        visit "/#{bronson.seller.slug}/garments/#{bronson.id}"
        click_link_or_button("add to cart")
        expect(page).to have_content(1)
        click_link_or_button("plus-#{bronson.id}")
        expect(page).to have_content(2)
        click_link_or_button("minus-#{bronson.id}")
        expect(page).to have_content(1)
      end
      it "destroys a garment" do
        kitty = create(:garment, name: "kitty", seller_id: Seller.last.id)
        visit "/#{kitty.seller.slug}/garments/#{kitty.id}"
        click_link_or_button("add to cart")
        click_link_or_button("plus-#{kitty.id}")
        click_link_or_button("remove-#{kitty.id}")
        expect(page).not_to have_content("kitty")
      end
    end
  end
end
