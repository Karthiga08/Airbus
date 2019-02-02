class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.date :date_of_birth
      t.string :gener
      t.string :phone_number
      t.string :email
      t.string :adult_count
      t.string :child_count
      t.string :infant_count
      t.timestamps
    end
  end
end
