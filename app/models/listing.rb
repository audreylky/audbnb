class Listing < ApplicationRecord
	enum home_type: [:highrise, :landed]
	# enum stay_type: [:shared, :private, :entire]
	enum stay_type: ['Shared', 'Private', 'Entire']

	belongs_to :host, class_name: 'User', foreign_key: 'user_id'
	has_many :reservations, inverse_of: :listing, dependent: :destroy
	

	has_many :payments, through: :reservations

	# M-M relationship is Bi-directional
	has_many :tags, through: :listing_tags
	has_many :listing_tags, dependent: :destroy
	
	

	serialize :photos, JSON
	mount_uploaders :photos, PhotoUploader
	
end

