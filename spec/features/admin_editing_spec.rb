require "rails_helper"
describe "admin editing mode" do
  context "for breeds" do
    xit "allows admin to change all fields" do
      create(:user, role: 1)
      breed = create(:breed)
      visit edit_admin_breed_path(breed)

      fill_in "edit name", with: "TEst_name"
      fill_in "edit description", with: "test_description"
      fill_in "edit image_path", with: "test_image_path"
      fill_in "edit retired", with: true
      click_link_or_button("Submit")

      within("#flash-editcomplete") do
        expect(page).to have_content("Test name edited!")
      end
      expect(current_path).to eq("/admin/breeds/test_name/edit")
    end

    xit "changes all different types of names" do
      create(:user, role: 1)
      breed = create(:breed, name: "Percifolus gamatron")
      visit edit_admin_breed_path(breed)

      fill_in "edit name", with: "name_test"
      click_link_or_button("Submit")
      within("#flash-editcomplete") do
        expect(page).to have_content("Name test edited!")
      end
    end
  end
  context "for individual cats" do
    xit "allows admin to change name and description" do
      create(:user, role: 1)
      cat = create(:cat, name: "garfield")
      visit edit_admin_cat_path(cat)

      fill_in "edit name", with: "TEst_name"
      fill_in "edit description", with: "test_description"
      fill_in "edit price", with: 10000
      fill_in "edit image_path", with: "test_image_path"
      fill_in "edit retired", with: true
      click_link_or_button("Submit")

      within("#flash-editcomplete") do
        expect(page).to have_content("Test name edited!")
      end
      expect(current_path).to eq("/admin/cats/#{cat.id}/edit")
    end

    xit "changes all different types of names" do
      create(:user, role: 1)
      cat = create(:cat, name: "Percival")
      visit edit_admin_cat_path(cat)

      fill_in "edit name", with: "Perci the cat"
      click_link_or_button("Submit")
      within("#flash-editcomplete") do
        expect(page).to have_content("Perci the cat edited!")
      end
    end
  end
end
