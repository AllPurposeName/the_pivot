class Seed
  include FactoryGirl
  def call
    generate_admin_user
    generate_categories
    #generate_sellers
    #generate_garments
    generate_users
    generate_croc_pot
    generate_leatherface
    generate_furmanchu
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
    seller = FactoryGirl.create(:seller, store_name: "The Croc Pot", image_path: "croctee.jpg", description: "I like crocodiles. A little too much.")
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

  def generate_leatherface
    seller = FactoryGirl.create(:seller, store_name: "Leatherface", image_path: "leatherface.jpg", description: "You may remember me from my former profession...")
    FactoryGirl.create(:user, username: "leather", email: "leather@leather.com", userable_id: seller.id, userable_type: "Seller")
    seller.garments.create(name: "Leather Gloves for Her", price: 4500, image_path: "leather_gloves.jpg", description: "They may look dainty, but they prevent calluses when using a chainsaw. Safety first.")
    seller.garments.create(name: "Polka Dotted Black Gloves", price: 5000, image_path: "leather_gloves2.jpg", description: "I painstakingly applied each black dot by hand. No wonder I'm crazy!")
    seller.garments.create(name: "Strapping Gloves", price: 10000, image_path: "leather_gloves3.jpg", description: "I'm sure to rub each pair on my face for several hours before shipping them out.")
    seller.garments.create(name: "Simple Leather Jacket", price: 10000, image_path: "leather_jacket.png", description: "To keep it cheap I use immigrant skin.")
    seller.garments.create(name: "Shapely Jacket", price: 100000, image_path: "leather_jacket2.png", description: "Male only. All that extra room really helps with the moobs.")
    seller.garments.create(name: "Jacket with Hood", price: 150000, image_path: "leather_jacket3.png", description: "For hiding your face around those youngsters.")
    seller.garments.create(name: "Fur Man Chu Inspired Jacket", price: 10000, image_path: "leather_jacket4.jpg", description: "Does not come with glasses. If you ask for the glasses I will come to your house and peel your face off.")
    seller.garments.create(name: "Leather Pants and Shoe Combo", price: 300000, image_path: "leather_pants2.jpg", description: "These come in two sizes: extra tight and extra extra tight.")
    seller.garments.create(name: "Business Class Pants", price: 400000, image_path: "leather_pants3.jpg", description: "For the working man who wants extremely uncomfortable genitals.")
  end

  def generate_furmanchu
    seller = FactoryGirl.create(:seller, store_name: "Furmanchu", image_path: "furmanchu.jpg", description: "Animal hair styled as well as my namesake.")
    FactoryGirl.create(:user, username: "fur", email: "fur@fur.com", userable_id: seller.id, userable_type: "Seller")
    seller.garments.create(name: "Fur After Dark", price: 850000, image_path: "fur_coat2.jpg", description: "Ancient Chinese Secret: Black is Back!")
    seller.garments.create(name: "Endangered Siberian Fox Hat", price: 30000, image_path: "fur_hat3.gif", description: "\"I'm finally vogue\", says this fox.")
    seller.garments.create(name: "Mongolian Style Gloves", price: 300000, image_path: "fur_gloves.gif", description: "Man with warm hands has warm heart... and big wallet.")
    seller.garments.create(name: "Cheap Fur Hat", price: 10000, image_path: "fur_hat.png", description: "For the part of your head your neckbeard doesn't cover.")
    seller.garments.create(name: "Fomorian Style Coat", price: 330000, image_path: "fur_coat.jpg", description: "Luxurious in red. When those Animal Rights activists throw blood on you.")
    seller.garments.create(name: "Workman's Hat", price: 14500, image_path: "fur_hat2.png", description: "Even I can't call this stylish. Complete with minibrim.")
    seller.garments.create(name: "Elderly Bearskin Coat", price: 125000, image_path: "fur_coat4.jpg", description: "Relax, it's just bear skin.")
  end

  def image
    Dir["app/assets/images/individuals/*.jpg"].sample.split("/").last
  end
end

Seed.call
