class ServicesController < ApplicationController
  def create
    service = Service.new(permitted_params)
    if service.save
      render json: {}, status: :ok
    else
      render json: { errors: service.errors.full_messages }, status: 422
    end
  end

  private

  def permitted_params
    params.permit(:name, :phone, :address)
  end
end