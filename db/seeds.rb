class Seed
  def call
    generate_admin_user
    generate_categories
    generate_sellers
    generate_items
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
      FactoryGirl.create(:user, username: Faker::Name.name, email: Faker::Internet.email, userable_id: seller.id, userable_type: "Seller")
      puts "Created Seller: #{seller.store_name}"
    end
  end

  def generate_croc_pot
    seller = FactoryGirl.create(:seller, store_name: "The Croc Pot")
    FactoryGirl.create(:user, username: "croc", email: "croc@croc.com", userable_id: seller.id, userable_type: "Seller")
    seller.cats.create(name: "Midnight Croc", price: 100000, image_path: "crocjacket.jpg", description: "Luxurious in black.")
    seller.cats.create(name: "Croc Wallet", price: 30000, image_path: "crocwallet.jpg", description: "Moneybag for him.")
    seller.cats.create(name: "Croc Purse", price: 300000, image_path: "crocbag.jpg", description: "Moneybag for her.")
    seller.cats.create(name: "Croc Shoes", price: 10000, image_path: "crocshoes.jpg", description: "Walk on thin croc.")
    seller.cats.create(name: "Fire Croc", price: 100000, image_path: "crockjacketred.jpg", description: "Luxurious in red.")
    seller.cats.create(name: "Croc Watchcase", price: 10000, image_path: "crocwatchcase.jpg", description: "Helps keep your croc skin watches taut.")
    seller.cats.create(name: "Croc Casual Shoes", price: 10000, image_path: "croccasualshoes.jpg", description: "Relax, it's just croc skin.")
    seller.cats.create(name: "Croc Boots", price: 10000, image_path: "crocboots.jpg", description: "These boots were made for croc'n.")
    seller.cats.create(name: "Croc Gloves", price: 10000, image_path: "crocgloves.jpg", description: "Rock, paper, crock!")
  end

  def image
    Dir["app/assets/images/individuals/*.jpg"].sample.split("/").last
  end
end

Seed.call
