class AccessoriesController < ApplicationController
  def index
    @accessories = if params[:direction].present?
                     Accessory.order(price: params[:direction].to_sym)
                   else
                     Accessory.order(:id)
                   end
  end
end