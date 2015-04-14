class AccessoriesController < ApplicationController
  def index
    @accessories = Accessory.all
    @accessories = if params[:order].present? && params[:order] == 'price'
                     @accessories.order(:price)
                   else
                     @accessories.order(:id)
                   end
  end
end