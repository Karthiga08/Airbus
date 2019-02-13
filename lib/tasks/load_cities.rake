require 'csv'

namespace :load_cities do
  desc "load cities"
  task origin_cities: :environment do
    csv_cities = File.read('public/worldcities.csv')
    cities = CSV.parse(csv_cities, :headers => true)
    cities.each do |city|
      value = city.to_hash
      OriginCity.find_or_create_by(name: value["city"])
    end
  end

  task destination_cities: :environment do
    csv_cities = File.read('public/worldcities.csv')
    cities = CSV.parse(csv_cities, :headers => true)
    cities.each do |city|
      value = city.to_hash
      DestinationCity.find_or_create_by(name: value["city"])
    end
  end
end
