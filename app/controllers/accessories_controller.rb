class AccessoriesController < ApplicationController
  def index
    @accessories = if params[:order].present? && params[:order] == 'price'
                     Accessory.order(:price)
                   else
                     Accessory.order(:id)
                   end
  end
end