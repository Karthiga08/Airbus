class CreateSeatCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :seat_categories do |t|
      t.references :plane, index: true
      t.string :name
      t.integer :number_of_seat_in_row
      t.integer :number_of_rows
      t.float :price
      t.timestamps
    end
  end
end
