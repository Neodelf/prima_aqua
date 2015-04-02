class AccessoriesController < ApplicationController
  def index
    @accessories = Accessory.order(:id)
  end
end