require 'rails_helper'

describe 'seller viewing dashboard', type: :feature do
  let(:seller) { create(:seller) }
  let(:user) { create(:user, userable_id: seller.id, userable_type: "Seller") }
  it 'displays the dashboard' do
    visit login_path
    fill_in "session[username]", with: user.username
    fill_in "session[password]", with: user.password
    click_link_or_button("log in")
    visit "/#{seller.slug}/dashboard"
    expect(page).to have_content(seller.name)
  end
end
