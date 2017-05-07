class Listing < ApplicationRecord
	enum home_type: [:highrise, :landed]
	# enum stay_type: [:shared, :private, :entire]
	enum stay_type: ['Shared', 'Private', 'Entire']

	belongs_to :user
	has_one :payment, through: :reservations
	
	has_many :listing_tags, dependent: :destroy
	has_many :tags, through: :listing_tags
	has_many :reservations, dependent: :destroy
	serialize :photos, JSON
	mount_uploaders :photos, PhotoUploader
	
end

