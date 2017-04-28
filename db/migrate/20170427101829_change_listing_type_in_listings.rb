class ChangeListingTypeInListings < ActiveRecord::Migration[5.0]
  def change
  	rename_column :listings, :listing_type, :stay_type
  end
end
