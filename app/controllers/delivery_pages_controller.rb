class DeliveryPagesController < ApplicationController
  def show
    @delivery_page = DeliveryPage.find(params[:id])
  end
end
