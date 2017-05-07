class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
    	t.references :reservation
    	t.integer :payment_amount
      t.timestamps
    end
  end
end
