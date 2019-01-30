class CreateSeats < ActiveRecord::Migration[5.2]
  def change
    create_table :seats do |t|
      t.references :plane, index: true
      t.references :seat_category, index: true
      t.string :seat_number
      t.string :pnr
      t.timestamps
    end
  end
end
