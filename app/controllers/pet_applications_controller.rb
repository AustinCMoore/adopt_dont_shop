class PetApplicationsController < ApplicationController
  def create
    # binding.pry
    @application = Application.find(params[:id])
    @new_pet = Pet.find(params[:search])
    @pet_application = PetApplication.create!(pet: @new_pet, application: @application, status: :pending)
    @pet_application.save
    redirect_to "/applications/#{@application.id}"
  end
end
