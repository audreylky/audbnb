class ChangeListingColumn < ActiveRecord::Migration[5.0]
  def change
  	change_column :listings, :home_type, 'integer USING CAST(home_type AS integer)'
  	change_column :listings, :listing_type, 'integer USING CAST(listing_type AS integer)'
  end
end

