require "rails_helper"
describe "Guest on the login page", type: :feature do

  context "there is as skip button" do
    it "login is not necessary" do
      visit "/login"
      within "#login" do
        click_link_or_button("cancel")
      end
      expect(current_path).to eq("/")
    end
  end

  context "there is a log in button" do
    it "logs in with valid data" do
      guests_identity = create(:user, username: "DJ", password: "pw")
      visit "/login"
      within "#login" do
        fill_in "session[username]", with: "DJ"
        fill_in "session[password]", with: "pw"
        click_link_or_button("log in")
      end

      expect(current_path).to eq("/login")
    end

    it "does not log in with invalid data" do
      create(:user, username: "Felix", password: "thegarment")

      visit "/login"
      within "#login" do
        fill_in "session[username]", with: "Felix"
        fill_in "session[password]", with: "thegarmentinthehat"
        click_link_or_button("log in")
      end

      expect(current_path).to eq("/login")
    end
  end
end
