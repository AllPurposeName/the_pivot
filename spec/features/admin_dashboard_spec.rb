require "rails_helper"
describe "admin dashboard" do
  it "when first logged in" do
    User.create(role: 1, username: "Adminguy", password: "adminpass", full_name: "DJ G", email: "admin_example@example.com",)
    visit login_path
    within "#login" do
      fill_in "session[username]", with: "Adminguy"
      fill_in "session[password]", with: "adminpass"
      click_link_or_button("log in")
    end

    expect(current_path).to eq("/admin/inventory")
    within("#flash-welcomeadmin") do
      expect(page).to have_content("Welcome, Adminguy!")
    end
    expect(page).to have_content("ALL GARMENTS")
    expect(page).to have_content("ALL CATEGORIES")
  end
  let(:admin) { User.create(role: 1, username: "Adminguy", password: "adminpass", full_name: "DJ G", email: "admin_example@example.com") }
  context "from the inventory" do
    it "links to edit category" do
      admin
      category = create(:category, name: "Fur",
                        description: "A long fanged feline for your long suffering appetite!",
                        image_path: "sabertooth_01.jpeg",
                        retired: false)

      visit login_path
      within "#login" do
        fill_in "session[username]", with: "Adminguy"
        fill_in "session[password]", with: "adminpass"
        click_link_or_button("log in")
      end
      click_link_or_button("#{category.name.downcase}")

      expect(current_path).to eq("/admin/categories/#{category.name.downcase}/edit")
      expect(page).to have_content("Fur")
      expect(page).to have_content("Description of Furs:")
      expect(page).to have_content("Image_path of Furs:")
      expect(page).to have_content("Retired status of Furs:")
      expect(page).to have_content("edit")
    end

    it "links to edit a specific garment" do
      admin
      brody = create(:garment, name: "brody")

        visit login_path
      within "#login" do
        fill_in "session[username]", with: "Adminguy"
        fill_in "session[password]", with: "adminpass"
        click_link_or_button("log in")
      end
      click_link_or_button("#{brody.name}")
      expect(current_path).to eq("/admin/garments/#{brody.id}/edit")
      expect(page).to have_content("#{brody.name.capitalize}")
      expect(page).to have_content("Description for #{brody.name.capitalize}:")
      expect(page).to have_content("Price for #{brody.name.capitalize}:")
      expect(page).to have_content("Image_path for #{brody.name.capitalize}:")
      expect(page).to have_content("Retired status for #{brody.name.capitalize}:")
      expect(page).to have_content("edit")
    end
  end
end
