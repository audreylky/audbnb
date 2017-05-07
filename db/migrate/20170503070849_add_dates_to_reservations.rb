class AddDatesToReservations < ActiveRecord::Migration[5.0]
  def change
  	add_column :reservations, :start_date, :date
  	add_column :reservations, :end_date, :date
  	remove_column :reservations, :booking_date
  end
end
