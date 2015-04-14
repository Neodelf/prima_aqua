class PompsController < ApplicationController
  def index
    @pomps = if params[:order].present? && params[:order] == 'price'
                     Pomp.order(:price)
                   else
                     Pomp.order(:id)
                   end
  end
end