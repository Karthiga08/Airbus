class AddAirplaneTypeToPlanes < ActiveRecord::Migration[5.2]
  def change
    add_column :planes, :plane_type, :string
    add_column :planes, :date, :date
  end
end
