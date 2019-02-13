class CreateOriginCities < ActiveRecord::Migration[5.2]
  def change
    create_table :origin_cities do |t|
      t.string :name
      t.timestamps
    end
  end
end
