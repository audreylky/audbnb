class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
    	t.string :home_type
    	t.string :listing_type
    	t.integer :guest
    	t.integer :bedroom
    	t.integer :bathroom
    	t.text :title
    	t.text :address
    	t.integer :price
    	t.references :user
    	t.timestamps
    end
  end
end