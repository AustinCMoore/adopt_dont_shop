class ApplicationsController < ApplicationController
  def index

  end

  def show
    @application = Application.find(params[:id])
    if params[:query] != nil
      @pets_found = Pet.search(params[:query])
    else
      @pets_found = []
    end
  end

  def new
  end

  def create
    @application = Application.new(
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: params[:description],
      full_address: params[:full_address],
      status: params[:status]
    )
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(@application.errors)}"
    end
  end

  def update
    @application = Application.find(params[:id])
    @new_pet = Pet.find(params[:search])
    @pet_application = PetApplication.create!(pet: @new_pet, application: @application, approved: true)
    redirect_to "/applications/#{@application.id}"
  end
end
