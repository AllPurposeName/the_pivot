require "rails_helper"
describe "admin orders" do
  it "displays a list of orders and filter buttons" do
      create(:user, username: "Adminguy", password: "adminpass", role: 1)
    visit login_path
    within "#login" do
      fill_in "session[username]", with: "Adminguy"
      fill_in "session[password]", with: "adminpass"
      click_link_or_button("log in")
    end

    Order.create(user_id: 1, status: 0)

    visit "/admin/orders"
    within(".orders") do
      expect(page).to have_content("1")
    end
  end
end
