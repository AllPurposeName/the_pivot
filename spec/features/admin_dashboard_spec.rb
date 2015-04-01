require "rails_helper"
describe "admin dashboard" do
  it "when first logged in" do
    User.create(role: 1, username: "Adminguy", password: "adminpass", full_name: "DJ G", email: "admin_example@example.com",)
    visit login_path
    fill_in "session[username]", with: "Adminguy"
    fill_in "session[password]", with: "adminpass"
    click_link_or_button("log in")

    expect(current_path).to eq("/admin/inventory")
    within("#flash-welcomeadmin") do
      expect(page).to have_content("Welcome, Adminguy!")
    end
    expect(page).to have_content("ALL CATS")
    expect(page).to have_content("ALL BREEDS")
  end
  let(:admin) { User.create(role: 1, username: "Adminguy", password: "adminpass", full_name: "DJ G", email: "admin_example@example.com") }
  context "from the inventory" do
    it "links to edit breed" do
      admin
      breedy = create(:breed, name: "Sabertooth",
                     description: "A long fanged feline for your long suffering appetite!",
                     image_path: "sabertooth_01.jpeg",
                     retired: false)

      visit login_path
      fill_in "session[username]", with: "Adminguy"
      fill_in "session[password]", with: "adminpass"
      click_link_or_button("log in")
      click_link_or_button("#{breedy.name.downcase}")

      expect(current_path).to eq("/admin/breeds/#{breedy.name.downcase}/edit")
      expect(page).to have_content("Sabertooth")
      expect(page).to have_content("Description of Sabertooths:")
      expect(page).to have_content("Image_path of Sabertooths:")
      expect(page).to have_content("Retired status of Sabertooths:")
      expect(page).to have_content("edit")
    end

    it "links to edit a specific cat" do
      admin
      brody = create(:cat, name: "brody")

      visit login_path
      fill_in "session[username]", with: "Adminguy"
      fill_in "session[password]", with: "adminpass"
      click_link_or_button("log in")
      click_link_or_button("#{brody.name}")
      expect(current_path).to eq("/admin/cats/#{brody.id}/edit")
      expect(page).to have_content("#{brody.name.capitalize}")
      expect(page).to have_content("Description for #{brody.name.capitalize}:")
      expect(page).to have_content("Price for #{brody.name.capitalize}:")
      expect(page).to have_content("Image_path for #{brody.name.capitalize}:")
      expect(page).to have_content("Retired status for #{brody.name.capitalize}:")
      expect(page).to have_content("edit")
    end
  end
end
