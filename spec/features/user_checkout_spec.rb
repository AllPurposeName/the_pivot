require "rails_helper"
describe "authenticated user checkout", type: :feature do
  before :each do
    seller = create(:seller)
    @garment = create(:garment, seller_id: seller.id)
    @user = User.create(role: 0, username: "guy", password: "pass", full_name: "DJ G", email: "example@example.com",)
    visit login_path
    within "#login" do
      fill_in "session[username]", with: "guy"
      fill_in "session[password]", with: "pass"
      click_link_or_button("log in")
    end
    visit seller_garment_path(id: @garment, slug: @garment.slug)
    click_link_or_button("add to cart")
  end

  it "gains items in cart when clicking the 'add to cart' button" do
    expect(page).to have_content(@garment.monify)
    expect(page).to have_content("cart")
  end

  it "is able to checkout their cart" do
    click_link_or_button("checkout")
    expect(@user.orders.count).to eq(1)
    expect(@user.orders.first.garments.count).to eq(1)
  end

  it "Can view their orders" do
    order = @user.orders.create(status: 0)
    order.order_garments.create(garment_id: @garment.id, quantity: 2)
    visit orders_path
    expect(page).to have_content(@garment.name)
  end

  it "can view an order from order index" do
    order = @user.orders.create(status: 0)
    order.order_garments.create(garment_id: @garment.id, quantity: 2)
    visit orders_path
    click_link_or_button("Order #1")
    expect(current_path).to eq("/orders/3")
  end

  it "can view the order indivually and you can see all of the info for that order" do
    order = @user.orders.create(status: 0)
    order.order_garments.create(garment_id: @garment.id, quantity: 2)
    visit orders_path
    click_link_or_button("Order #1")
    within("table") do
      expect(page).to have_content(@garment.name)
    end
  end
end
