require 'rails_helper'

RSpec.describe 'the shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_2.pets.create(name: 'Blinky', breed: 'Bengal', age: 2, adoptable: true)
    @application_1 = Application.create!(name: "Austin Moore", street_address: "9999 Imaginary Ave", city: "Laurel", state: "MD", zip_code: "99999", description: "I am very nice", full_address: "9999 Imaginary Ave, Laurel, MD 99999", status: :pending)
    @application_2 = Application.create!(name: "Noel Sitnick", street_address: "9999 Make Believe Rd", city: "Scaggsville", state: "MD", zip_code: "00001", description: "I am very sweet", full_address: "9999 Make Believe Rd, Scaggsville, MD 00001", status: :pending)
    @application_3 = Application.create!(name: "Daniel Sitnick", street_address: "9999 Made up street", city: "Baltimore", state: "MD", zip_code: "10001", description: "TBD", full_address: "9999 Make Believe Rd, Scaggsville, MD 00001", status: :in_progress)
    @pet_application_1 = PetApplication.create!(pet: @pet_1, application: @application_1, status: :pending)
    @pet_application_2 = PetApplication.create!(pet: @pet_4, application: @application_1, status: :pending)
    @pet_application_3 = PetApplication.create!(pet: @pet_2, application: @application_2, status: :pending)
    @pet_application_4 = PetApplication.create!(pet: @pet_3, application: @application_3, status: :pending)

    visit "/admin/shelters"
  end

  it "lists all Shelters names" do
    expect(page).to have_current_path("/admin/shelters")
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
  end

  it 'lists the shelters by name in reverse alphabetical order' do
    first = find("#shelter-#{@shelter_2.id}")
    second = find("#shelter-#{@shelter_3.id}")
    third = find("#shelter-#{@shelter_1.id}")

    expect(first).to appear_before(second)
    expect(second).to appear_before(third)

    within "#shelter-#{@shelter_2.id}" do
      expect(page).to have_content("Name: #{@shelter_2.name}")
    end

    within "#shelter-#{@shelter_3.id}" do
      expect(page).to have_content("Name: #{@shelter_3.name}")
    end

    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_content("Name: #{@shelter_1.name}")
    end
  end

  it "displays pending applications" do
    within '#pending-applications' do
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
      expect(page).to_not have_content(@shelter_3.name)
    end
  end
end
