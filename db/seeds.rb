class Seed
  def call
    generate_admin_user
    generate_categories
    generate_sellers
    generate_items
    generate_users
    generate_orders
    generate_default_user
  end

  def self.call
    new.call
  end

  private
  def generate_admin_user
    FactoryGirl.create(:user, username: "Jorge",
           role: 1,
           email: "jorge@turing.io")
  end

  def generate_default_user
    # Use build inside of create blocks to set up associations
    FactoryGirl.create(:user, username: "Richard", email: "richard@example.com") do |user|
      user.orders.build do |order|
        order.cats << Cat.order("RANDOM()").limit(1).first
      end
    end
  end

  def generate_orders
    100.times do
      user = User.order("RANDOM()").limit(1).first
      user.orders.create do |order|
        rand(1..10).times do
          order.cats << Cat.order("RANDOM()").limit(1).first
        end
      end
      puts "Created Orders For: #{user.username}"
    end
  end

  def generate_users
    10.times do
      user = FactoryGirl.create(:user, username: Faker::Name.name, email: Faker::Internet.email)
      puts "Created User: #{user.username}"
    end
  end

  def generate_categories
    5.times do
      category = FactoryGirl.create(:breed, name: Faker::Commerce.department)
      puts "Created Category: #{category.name}"
    end
  end

  def generate_items
    seller_count = Seller.count
    100.times do
      category = Breed.order("RANDOM()").limit(1).first
      item = category.cats.create(name: Faker::Commerce.product_name, price: Faker::Commerce.price.to_i, image_path: image, description: "x", seller_id: rand(1..seller_count))
      puts "Created Item: #{item.name}"
    end
  end

  def generate_sellers
    10.times do
      seller = FactoryGirl.create(:seller)
      user = FactoryGirl.create(:user, username: Faker::Name.name, email: Faker::Internet.email, userable_id: seller.id, userable_type: "Seller")
      puts "Created Seller: #{seller.store_name}"
    end
  end

  def image
    Dir["app/assets/images/individuals/*.jpg"].sample.split("/").last
  end
end

Seed.call
