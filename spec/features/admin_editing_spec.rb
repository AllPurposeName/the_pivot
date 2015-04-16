require "rails_helper"
describe "admin editing mode" do
  context "for individual garments" do
    it "allows admin to change name and description" do
      create(:user, username: "Adminguy", password: "adminpass", role: 1)
      garment = create(:garment, name: "garfield")

      visit login_path
      within "#login" do
        fill_in "session[username]", with: "Adminguy"
        fill_in "session[password]", with: "adminpass"
        click_link_or_button("log in")
      end

      visit edit_admin_garment_path(garment)

      fill_in "edit name", with: "TEst_name"
      fill_in "edit description", with: "test_description"
      fill_in "edit price", with: 10000
      fill_in "edit image_path", with: "test_image_path"
      click_link_or_button("Submit")

      within("#flash-editcomplete") do
        expect(page).to have_content("Test name edited!")
      end
      expect(current_path).to eq("/admin/garments/#{garment.id}/edit")
    end

    it "changes all different types of names" do
      create(:user, username: "Adminguy", password: "adminpass", role: 1)
      garment = create(:garment, name: "Percival")

      visit login_path
      within "#login" do
        fill_in "session[username]", with: "Adminguy"
        fill_in "session[password]", with: "adminpass"
        click_link_or_button("log in")
      end

      visit edit_admin_garment_path(garment)

      fill_in "edit name", with: "Perci the garment"
      click_link_or_button("Submit")
      within("#flash-editcomplete") do
        expect(page).to have_content("Perci the garment edited!")
      end
    end
  end
end
