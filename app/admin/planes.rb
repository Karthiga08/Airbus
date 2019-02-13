ActiveAdmin.register Plane do
  config.clear_sidebar_sections!
  permit_params :name, :plane_type, :date, :plane_time, :origin_city_id, :destination_city_id, seat_categories_attributes: %i(id name number_of_seat_in_row number_of_rows price)

  index title: 'Plane Management' do
    column 'Name' do |plane|
      plane.try(:name)
    end
    column 'Plane Type' do |plane|
      plane.try(:plane_type)
    end
    column 'Date' do |plane|
      plane.try(:date)
    end
    column 'Plane Takeoff Time' do |plane|
      plane.plane_takeoff
    end
    column 'Origin' do |plane|
      plane.try(:origin_city).try(:name)
    end
    column 'Destination' do |plane|
      plane.try(:destination_city).try(:name)
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :plane_type
      f.input :date, as: :datepicker, datepicker_options: { min_date: "Date.today" }
      f.input :plane_time, label: 'Plane Takeoff Time'
      f.input :origin_city_id, as: :select, collection: OriginCity.all.map { |a| [a.name, a.id]  }
      f.input :destination_city_id, as: :select, collection: DestinationCity.all.map { |a| [a.name, a.id]  }
      f.has_many :seat_categories, for: [:seat_categories, f.object.seat_categories.present? ? f.object.seat_categories : 3.times { f.object.seat_categories.build }], new_record: false do |ff|
        ff.input :name, label: 'Class Name', as: :select, collection: ['First Class', 'Business Class', 'Economic Class'], prompt: 'Select'
        ff.input :number_of_seat_in_row
        ff.input :number_of_rows
        ff.input :price, label: 'Price($)'
      end
      f.actions
    end
  end

  show action: 'get' do
    attributes_table do
    row 'Name' do |plane|
      plane.try(:name)
    end
    row 'Plane Type' do |plane|
      plane.try(:plane_type)
    end
    row 'Date' do |plane|
      plane.try(:date)
    end
    row 'Plane Takeoff Time' do |plane|
      plane.plane_takeoff
    end
    row 'Origin' do |plane|
      plane.try(:origin_city).try(:name)
    end
    row 'Destination' do |plane|
      plane.try(:destination_city).try(:name)
    end
    end
  end
end
