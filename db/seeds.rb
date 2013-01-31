# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


states = State.create([ { name: 'North Carolina' },
                        { name: 'Ohio' }])

cities = City.create([  { name: 'Raleigh', state_id: states.first.id },
                        { name: 'Durham', state_id: states.first.id },
                        { name: 'Cincinnati', state_id: states.last.id }])

#neighborhoods = Neighborhood.create([ { name: 'Five Points', city_id: cities.first.id },
#                                      { name: 'Glenwood South', city_id: cities.first.id },
#                                      { name: 'Cameron Village', city_id: cities.first.id },
#                                      { name: 'Anderson', city_id: cities.last.id },
#                                      { name: 'Hyde Park', city_id: cities.last.id }])
