class CreateUserSeats < ActiveRecord::Migration[5.2]
  def change
    create_table :user_seats do |t|
      t.references :user, index: true
      t.references :seat, index: true
      t.timestamps
    end
  end
end
