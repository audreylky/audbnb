class CreateListingTags < ActiveRecord::Migration[5.0]
  def change
    create_table :listing_tags do |t|
    	t.references :tag 
    	t.references :listing

      t.timestamps
    end
  end
end
