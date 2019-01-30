class CreatePlanes < ActiveRecord::Migration[5.2]
  def change
    create_table :planes do |t|
      t.string :name
      t.string :origin
      t.string :destination
      t.timestamps
    end
  end
end
