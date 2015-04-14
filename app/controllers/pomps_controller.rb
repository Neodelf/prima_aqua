class PompsController < ApplicationController
  def index
    @pomps = if params[:order].present? && params[:order] == 'price'
                     Pomp.order(:price)
                   else
                     Pomp.order(:id)
                   end
    @tags = Tag.includes(:coolers).limit(4)
  end
end