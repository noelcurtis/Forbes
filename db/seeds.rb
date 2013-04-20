def states_and_cities
  {
    'Andhra Pradesh' => ['Rajasthan', 'Visakhapatnam'],
    'Bihar' => ['Patna'],
    'Delhi' => ['Delhi'],
    'Gujarat' => ['Ahmedabad', 'Surat', 'Vadodara', 'Rajkot'],
    'Haryana' => ['Faridabad'],
    'Karnataka' => ['Bangalore'],
    'Madhya Pradesh' => ['Indore', 'Bhopal'],
    'Maharashtra' => ['Mumbai', 'Pune', 'Nagpur', 'Thane', 'Pimpri-Chinchwad', 'Nashik', 'Kalyan-Dombivali', 'Vasai-Virar'],
    'Punjab' => ['Ludhiana'], 
    'Rajasthan' => ['Jaipur'],
    'Tamil Nadu' => ['Chennai'],
    'Uttar Pradesh' => ['Lucknow', 'Kanpur', 'Ghaziabad', 'Agra', 'Meerut', 'Varanasi'],
    'West Bengal' => ['Kolkata']
  }
end

def mumbai_neighborhoods
  [
    "Churchgate",
    "Marine Lines",
    "Charni Road",
    "Grant Road",
    "Mumbai Central",
    "Mahalaxmi",
    "Lower Parel",
    "Elphinston Road",
    "Dadar",
    "Matunga",
    "Mahim",
    "Bandra",
    "Khar",
    "Santacruz",
    "Vile Parle East",
    "Vile Parle West",
    "Andheri East",
    "Andheri West",
    "Jogeshwari East",
    "Jogeshwari West",
    "Goregaon East ",
    "Goregaon West",
    "Malad",
    "Kandivali",
    "Borivali"
  ]
end

def admin
  @admin ||= User.find_by_email('admin@gmail.com') || create_admin!
end

def create_admin!
  User.create(first_name: 'Peter', last_name: 'Parker', email: 'admin@gmail.com',
              password: 'password', gender: 'male', birthday: Date.today)
end

def build_states_and_cities!
  states_and_cities.each do |state_name, cities|
    state = State.find_by_name(state_name) || State.create(name: state_name)

    cities.each do |city_name|
      unless City.find_by_name(city_name)
        puts "creating city #{city_name} for state #{state.name}"
        City.create(name: city_name, state_id: state.id)
      end
    end
  end
end

def build_neighborhoods!
  mumbai = City.find_by_name('Mumbai')
  if mumbai
    mumbai_neighborhoods.each do |neighborhood_name|
      puts "creating neighborhood #{neighborhood_name} for city #{mumbai.name}"
      Neighborhood.create(name: neighborhood_name, city_id: mumbai.id)
    end
  end
end


def associate_seeded_neighborhoods_with_admin!
  mumbai = City.find_by_name('Mumbai')
  if mumbai
    Neighborhood.where(city_id: mumbai.id).each do |neighborhood|
      puts "Setting admin user as owner of #{neighborhood.name}"
      admin_neighborhood_count = admin.neighborhoods.count
      NeighborhoodUser.create(
        neighborhood_id: neighborhood.id,
        user_id: admin.id,
        primary: admin_neighborhood_count == 0
      )
    end
  end
end

build_states_and_cities!
build_neighborhoods!
associate_seeded_neighborhoods_with_admin!
