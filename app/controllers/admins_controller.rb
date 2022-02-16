class AdminsController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY name desc")
    @pending_shelters = Shelter.select_shelters_w_pending_apps
  end

  def show
    @application = Application.find(params[:id])
  end
end
