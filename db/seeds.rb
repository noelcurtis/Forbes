require 'csv'

file = CSV.read("db/seeds/GeoPC_IN.csv")

count = 0
file.each do |location|
  unless count == 0
    State.create!(name: location[4]) unless State.exists?(name: location[4])
    City.create!(name: location[9], state_id: State.find_by_name(location[4]).id)
  end
  count += 1
  puts count
  break if count == 200 # Temporary
end
