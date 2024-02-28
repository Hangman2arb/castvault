# Asumiendo que ya tienes users y forms creados
user_ids = User.pluck(:id)
form_ids = Form.pluck(:id)

10000.times do
  Profile.create!(
    name: Faker::Name.first_name,
    surname: Faker::Name.last_name,
    birthdate: Faker::Date.between(from: '1980-01-01', to: '2000-12-31'),
    ethnicity: Form::ETHNICITY_OPTIONS.sample,
    gender: Form::GENDER_OPTIONS.sample,
    city: Faker::Address.city,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.cell_phone,
    agency: [true, false].sample,
    agent_name: Faker::Company.name,
    agent_email: Faker::Internet.email,
    agent_phone: Faker::PhoneNumber.phone_number,
    height: rand(150..200),
    shirt_size: rand(1..5),
    pants_size: rand(1..5),
    shoe_size: rand(36..46),
    hair_type: Form::HAIR_TYPE_OPTIONS.sample,
    hair_color: Form::HAIR_COLOR_OPTIONS.sample,
    eye_color: Form::EYE_COLOR_OPTIONS.sample,
    passport: [true, false].sample,
    driving_license: [true, false].sample,
    food_allergies: Faker::Food.ingredient,
    web: Faker::Internet.domain_name,
    twitter: "@#{Faker::Internet.username}",
    facebook: Faker::Internet.username,
    instagram: "@#{Faker::Internet.username}",
    tik_tok: "@#{Faker::Internet.username}",
    is_an_actor: [true, false].sample,
    languages: Form::LANGUAGES_OPTIONS.sample(2),
    available_for: Form::AVAILABLE_FOR_OPTIONS.sample(2),
    sports_outdoor: Form::FEATURES_OPTIONS[:sports_outdoor].sample(2),
    sports_watersports: Form::FEATURES_OPTIONS[:sports_watersports].sample(2),
    # Añade aquí más campos según sea necesario
    form_id: form_ids.sample,
    user_id: user_ids.sample
  )
end

puts 'Profiles created!'
