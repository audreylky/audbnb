# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seed Users
user = {}
user['password'] = '1234'

ActiveRecord::Base.transaction do
  20.times do 
    user['name'] = Faker::Name.name 
    user['email'] = Faker::Internet.email
    user['gender'] = rand(1..2)
    User.create(user)
  end
end 

# Seed Listings
listing = {}
uids = User.pluck(:id)

ActiveRecord::Base.transaction do
  20.times do 
    listing['title'] = Faker::App.name
    listing['home_type'] = rand(0..1)
    listing['stay_type'] = rand(0..2)

    listing['bathroom'] = rand(1..5)
    listing['bedroom'] = rand(1..6)
    listing['guest'] = rand(1..10)

    listing['address'] = Faker::Address.street_address

    listing['price'] = rand(80..500)

    listing['user_id'] = uids.sample

    Listing.create(listing)
  end
 end

# Seed ListingTags
ltag = {}

tag_ids = Tag.pluck(:id)
listing_ids = Listing.pluck(:id)

ActiveRecord::Base.transaction do
	20.times do
		ltag['listing_id'] = listing_ids.sample
		ltag['tag_id'] = tag_ids.sample
		ListingTag.create(ltag)
	end
end