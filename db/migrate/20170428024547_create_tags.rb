class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|

    	t.integer :name
    	
    	t.integer :smoking
    	t.integer :wifi
    	t.integer :breakfast
    	t.integer :aircon
      t.timestamps
    end
  end
end
