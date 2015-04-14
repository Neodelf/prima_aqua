class PompsController < ApplicationController
  def index
    @pomps = Pomp.all
    @pomps = if params[:order].present? && params[:order] == 'price'
               @pomps.order(:price)
             else
               @pomps.order(:id)
             end
    @tags = Tag.includes(:coolers).limit(4)
  end
end