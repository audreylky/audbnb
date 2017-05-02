class RenamePhotoInListings < ActiveRecord::Migration[5.0]
  def change
  	rename_column :listings, :photo, :photos
  end
end
