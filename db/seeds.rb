require 'csv'

file = CSV.read("db/seeds/indian_states_and_cities.csv")

file.each do |pair|
  State.create!(name: pair.last) unless State.exists?(name: pair.last)
  City.create!(name: pair.first, state_id: State.find_by_name(pair.last).id)
end
