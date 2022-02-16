class PetApplicationsController < ApplicationController
  def create
    @application = Application.find(params[:id])
    @new_pet = Pet.find(params[:search])
    @pet_application = PetApplication.create!(pet: @new_pet, application: @application, status: :pending)
    @pet_application.save
    redirect_to "/applications/#{@application.id}"
  end

  def update
    @reviewed_pet_app = PetApplication.find(params[:petappid])
    @reviewed_pet_app.update(status: params[:status])
    redirect_to "/admin/applications/#{@reviewed_pet_app.application_id}"
  end
end
