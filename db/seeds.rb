100.times do |_n|
  email = Faker::Internet.email
  password = 'password'
  name = Faker::Pokemon.name
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
