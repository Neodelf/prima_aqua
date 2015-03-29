class PhoneCallsController < ApplicationController
  def create
    phone_call = PhoneCall.new(permitted_params)
    if phone_call.save
      render json: {}, status: :ok
    else
      render json: { errors: phone_call.errors.full_messages }, status: 422
    end
  end

  private

  def permitted_params
    params.permit(:name, :phone, :time)
  end
end
