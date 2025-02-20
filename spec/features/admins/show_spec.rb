require 'rails_helper'

RSpec.describe 'the admin application show page' do
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
    @pet_application_5 = PetApplication.create!(pet: @pet_1, application: @application_2, status: :pending)

    visit "/admin/applications/#{@application_1.id}"
  end

  it "displays pending pet_applications for a pending application" do
    expect(page).to have_current_path("/admin/applications/#{@application_1.id}")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_4.name)
    expect(page).to_not have_content(@pet_2.name)
    expect(page).to_not have_content(@pet_3.name)

    visit "/admin/applications/#{@application_2.id}"
    expect(page).to have_current_path("/admin/applications/#{@application_2.id}")
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_1.name)
    expect(page).to_not have_content(@pet_3.name)
    expect(page).to_not have_content(@pet_4.name)
  end

  it "has a link to approve a specific pet" do
    expect(page).to have_button("Approve: #{@pet_1.name}")
    expect(page).to have_button("Approve: #{@pet_4.name}")
    expect(page).to_not have_button("Approve: #{@pet_2.name}")
    expect(page).to_not have_button("Approve: #{@pet_3.name}")
  end

  it "buttons to the show page upon approving a pet" do
    click_button("Approve: #{@pet_1.name}")
    expect(page).to have_current_path("/admin/applications/#{@application_1.id}")
  end

  it "does not have button to approve a pet after clicking approve pet" do
    click_button("Approve: #{@pet_1.name}")

    expect(page).to have_button("Approve: #{@pet_4.name}")
    expect(page).to_not have_button("Approve: #{@pet_1.name}")
  end

  it "displays pet status is approved after clicking approve pet" do
    click_button("Approve: #{@pet_1.name}")

    expect(page).to have_content("#{@pet_1.name} has been approved!")
    expect(page).to_not have_content("#{@pet_4.name} has been approved!")
  end

  it "buttons to the show page upon rejecting a pet" do
    click_button("Reject: #{@pet_1.name}")
    expect(page).to have_current_path("/admin/applications/#{@application_1.id}")
  end

  it "does not have button to approve or reject a pet after clicking reject pet" do
    click_button("Reject: #{@pet_1.name}")

    expect(page).to have_button("Reject: #{@pet_4.name}")
    expect(page).to_not have_button("Reject: #{@pet_1.name}")
    expect(page).to_not have_button("Approve: #{@pet_1.name}")
  end

  it "displays pet status is rejected after clicking reject pet" do
    click_button("Reject: #{@pet_1.name}")

    expect(page).to have_content("#{@pet_1.name} has been rejected!")
    expect(page).to_not have_content("#{@pet_4.name} has been rejected!")
  end

  it "one pet application's status does not affect another's" do
    click_button("Reject: #{@pet_1.name}")

    visit "/admin/applications/#{@application_2.id}"

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_button("Reject: #{@pet_1.name}")
  end
end
