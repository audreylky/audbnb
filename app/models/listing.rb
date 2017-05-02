class Listing < ApplicationRecord
	enum home_type: [:highrise, :landed]
	# enum stay_type: [:shared, :private, :entire]
	enum stay_type: ['Shared', 'Private', 'Entire']

	belongs_to :user
	has_many :listing_tags, dependent: :destroy
	has_many :tags, through: :listing_tags
	serialize :photos, JSON
	mount_uploader :photos, PhotoUploader
	
end

