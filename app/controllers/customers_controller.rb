class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.includes(:service_area).order("service_areas.name, customers.name")
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customers_path, notice: "Successfully created!"
    else
      flash.now[:alert] = @customer.errors.map(&:message).join(", ")
      render action: :new, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to customers_path, notice: "Successfully updated!" }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(ActionView::RecordIdentifier.dom_id(@customer, :status), partial: "customers/status_badge", locals: { customer: @customer }),
            turbo_stream.update(ActionView::RecordIdentifier.dom_id(@customer, :update_status), partial: "customers/update_status", locals: { customer: @customer })
          ]
        end
      else
        format.html do
          flash.now[:alert] = errors
          render action: :edit, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    if @customer.destroy
      redirect_to customers_path, notice: "#{@customer.name.capitalize} was successfully deleted!"
    else
      flash.now[:alert] = @customer.errors.map(&:message).join(", ")
      render action: :index, status: :unprocessable_entity
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :primary_contact, :secondary_contact, :email, :address, :service_area_id, :status, :credit_limit)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
