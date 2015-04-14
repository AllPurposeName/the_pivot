require "rails_helper"
describe "user creates a store", type: :feature do
  before :each do
    @user = User.create(role: 0, username: "guy", password: "pass", full_name: "DJ G", email: "example@example.com",)
    visit login_path
    within "#login" do
      fill_in "session[username]", with: "guy"
      fill_in "session[password]", with: "pass"
      click_link_or_button("log in")
    end
    visit user_path(@user)
  end

  it 'should allow them to create a store' do
    store_name = "Tino's Closet"
    click_link_or_button "Create a store"
    fill_in "seller[store_name]", with: store_name
    click_link_or_button("Create Store")
    expect(page).to have_content(store_name)
  end

  it 'should allow them to create new items' do
    seller = create(:seller)
    @user.update(userable_id: seller.id, userable_type: "Seller")
    visit user_path(@user)
    click_link_or_button seller.store_name
    expect(page).to have_content("Create New Garment")
  end
end
