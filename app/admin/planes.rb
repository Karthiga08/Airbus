ActiveAdmin.register Plane do
  config.clear_sidebar_sections!
  permit_params :name, :plane_type, :date, :origin, :destination, seat_categories_attributes: %i(id name number_of_seat_in_row number_of_rows price)

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
    column 'Origin' do |plane|
      plane.try(:origin)
    end
    column 'Destination' do |plane|
      plane.try(:destination)
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :plane_type
      f.input :date, as: :datepicker, datepicker_options: { min_date: "Date.today" }
      f.input :origin
      f.input :destination
      f.has_many :seat_categories, for: [:seat_categories, f.object.seat_categories.present? ? f.object.seat_categories : 3.times { f.object.seat_categories.build }], new_record: false do |ff|
        ff.input :name, label: 'Class Name', as: :select, collection: ['First Class', 'Business Class', 'Economic Class'], prompt: 'Select'
        ff.input :number_of_seat_in_row
        ff.input :number_of_rows
        ff.input :price
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
    row 'Origin' do |plane|
      plane.try(:origin)
    end
    row 'Destination' do |plane|
      plane.try(:destination)
    end
    end
  end
end
