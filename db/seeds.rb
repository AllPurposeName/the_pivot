class Seed
  include FactoryGirl
  def call
    generate_admin_user
    generate_categories
    generate_sellers
    generate_garments
    generate_users
    generate_orders
    generate_default_user
    generate_croc_pot
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
      user.orders.create do |order|
        order.garments << Garment.order("RANDOM()").limit(1).first
      end
    end
  end

  def generate_orders
    100.times do
      user = User.order("RANDOM()").limit(1).first
      user.orders.create do |order|
        rand(1..10).times do
          order.garments << Garment.order("RANDOM()").limit(1).first
        end
      end
      puts "Created Orders For: #{user.username}"
    end
  end

  def generate_users
    10.times do
      user = FactoryGirl.create(:user, username: Faker::Name.first_name, email: Faker::Internet.email)
      puts "Created User: #{user.username}"
    end
  end

  def generate_categories
    5.times do
      category = FactoryGirl.create(:category, name: Faker::Commerce.department)
      puts "Created Category: #{category.name}"
    end
  end

  def generate_garments
    seller_count = Seller.count
    100.times do
      category = Category.order("RANDOM()").limit(1).first
      garment = category.garments.create(name: Faker::Commerce.product_name, price: Faker::Commerce.price.to_i * 100, image_path: image, description: "x", seller_id: rand(1..seller_count))
      puts "Created Item: #{garment.name}"
    end
  end

  def generate_sellers
    10.times do
      seller = FactoryGirl.create(:seller)
      FactoryGirl.create(:user, username: Faker::Name.name, email: Faker::Internet.email, userable_id: seller.id, userable_type: "Seller")
      puts "Created Seller: #{seller.store_name}"
    end
  end

  def generate_croc_pot
    seller = FactoryGirl.create(:seller, store_name: "The Croc Pot")
    FactoryGirl.create(:user, username: "croc", email: "croc@croc.com", userable_id: seller.id, userable_type: "Seller")
    seller.garments.create(name: "Midnight Croc", price: 100000, image_path: "crocjacket.jpg", description: "Luxurious in black.")
    seller.garments.create(name: "Croc Wallet", price: 30000, image_path: "crocwallet.jpg", description: "Moneybag for him.")
    seller.garments.create(name: "Croc Purse", price: 300000, image_path: "crocbag.jpg", description: "Moneybag for her.")
    seller.garments.create(name: "Croc Shoes", price: 10000, image_path: "crocshoes.jpg", description: "Walk on thin croc.")
    seller.garments.create(name: "Fire Croc", price: 100000, image_path: "crockjacketred.jpg", description: "Luxurious in red.")
    seller.garments.create(name: "Croc Watchcase", price: 10000, image_path: "crocwatchcase.jpg", description: "Helps keep your croc skin watches taut.")
    seller.garments.create(name: "Croc Casual Shoes", price: 10000, image_path: "croccasualshoes.jpg", description: "Relax, it's just croc skin.")
    seller.garments.create(name: "Croc Boots", price: 10000, image_path: "crocboots.jpg", description: "These boots were made for croc'n.")
    seller.garments.create(name: "Croc Gloves", price: 10000, image_path: "crocgloves.jpg", description: "Rock, paper, crock!")
  end

  def image
    Dir["app/assets/images/individuals/*.jpg"].sample.split("/").last
  end
end

Seed.call
