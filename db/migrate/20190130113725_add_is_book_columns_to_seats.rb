class AddIsBookColumnsToSeats < ActiveRecord::Migration[5.2]
  def change
    add_column :seats, :is_booked, :boolean, default: false
  end
end
