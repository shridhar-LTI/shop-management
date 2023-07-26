class ServiceAreasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service_area, only: [:edit, :update, :destroy]

  def index
    @service_areas = ServiceArea.all.order(:name)
  end

  def new
    @service_area = ServiceArea.new
  end

  def edit
  end

  def create
    @service_area = ServiceArea.create(service_area_params)
    if @service_area.save
      redirect_to service_areas_path, notice: "Saved successfully"
    else
      flash.now[:alert] = @service_area.errors.map(&:message).join(", ")
      render action: :new, status: :unprocessable_entity
    end
  end

  def update
    if @service_area.update(service_area_params)
      redirect_to service_areas_path, notice: "Updated successfully"
    else
      flash.now[:alert] = @service_area.errors.map(&:message).join(", ")
      render action: :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @service_area.destroy
      redirect_to service_areas_path, notice: "Deleted successfully"
    else
      flash.now[:alert] = @service_area.errors.map(&:message).join(", ")
      render action: :index, status: :unprocessable_entity
    end
  end

  private

  def set_service_area
    @service_area = ServiceArea.find(params[:id])
  end

  def service_area_params
    params.require(:service_area).permit(:name)
  end
end
