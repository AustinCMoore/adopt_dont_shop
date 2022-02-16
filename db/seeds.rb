# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
pet_3 = shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
pet_4 = shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
pet_5 = shelter_2.pets.create(name: 'Blinky', breed: 'bengal', age: 2, adoptable: true)
pet_6 = shelter_2.pets.create(name: 'Clyde', breed: 'tabby', age: 3, adoptable: true)

application_1 = Application.create!(name: "Austin Moore", street_address: "9999 Imaginary Ave", city: "Laurel", state: "MD", zip_code: "99999", description: "I am very nice", full_address: "9999 Imaginary Ave, Laurel, MD 99999", status: :pending)
application_2 = Application.create!(name: "Noel Sitnick", street_address: "9999 Make Believe Rd", city: "Scaggsville", state: "MD", zip_code: "00001", description: "I am very sweet", full_address: "9999 Make Believe Rd, Scaggsville, MD 00001", status: :pending)
application_3 = Application.create!(name: "Daniel Sitnick", street_address: "9999 Made up street", city: "Baltimore", state: "MD", zip_code: "10001", description: "TBD", full_address: "9999 Make Believe Rd, Scaggsville, MD 00001", status: :in_progress)

pet_application_1 = PetApplication.create!(pet: pet_1, application: application_1, status: :pending)
pet_application_2 = PetApplication.create!(pet: pet_5, application: application_1, status: :pending)
pet_application_3 = PetApplication.create!(pet: pet_2, application: application_2, status: :pending)
pet_application_4 = PetApplication.create!(pet: pet_4, application: application_2, status: :pending)
pet_application_5 = PetApplication.create!(pet: pet_3, application: application_3, status: :pending)
