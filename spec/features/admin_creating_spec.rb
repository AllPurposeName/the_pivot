require "rails_helper"
describe "admin creating mode" do
  context "for breeds" do
    xit "allows admin to create a new breed" do
      create(:user, role: 1)
      visit new_admin_breed_path

      fill_in "enter name", with: "TEst_new_name"
      fill_in "enter description", with: "test_new_description"
      fill_in "enter image_path", with: "test_new_image_path"
      fill_in "enter retired", with: true
      click_link_or_button("Create")

      within("#flash-newcomplete") do
        expect(page).to have_content("Test new name created!")
      end
      expect(current_path).to eq("/admin/breeds/test_new_name")
    end

    xit "doesn't allow the admin to not fill in any fields" do
      create(:user, role: 1)
      visit new_admin_breed_path

      fill_in "enter name", with: "TEst_fail_name"
      click_link_or_button("Create")
      within("#flash-newfail") do
        expect(page).to have_content("fill every field in with a valid entry")
      end
    end
  end

  context "for individual cats" do
    xit "allows admin to create a cat" do
      visit new_admin_cat_path

      fill_in "enter name", with: "TEst_new name"
      fill_in "enter description", with: "test_new_description"
      fill_in "enter price", with: 1000
      fill_in "enter image_path", with: "test_new_image_path"
      fill_in "enter retired", with: true
      click_link_or_button("Create")

      within("#flash-newcomplete") do
        expect(page).to have_content("Test new name created!")
      end
      cat = Cat.find_by(name: "TEst_new name")
      expect(current_path).to eq("/admin/cats/#{cat.id}")
    end

    xit "changes all different types of names" do
      create(:user, role: 1)
      visit new_admin_cat_path

      fill_in "enter name", with: "Perci the cat"
      click_link_or_button("Create")
      within("#flash-newfail") do
        expect(page).to have_content("Please fill every field in with a valid")
      end
    end
  end
end
