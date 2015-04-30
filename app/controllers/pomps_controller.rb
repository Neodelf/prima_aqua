class PompsController < ApplicationController
  def index
    @pomps = if params[:direction].present?
                     Pomp.order(price: params[:direction].to_sym)
                   else
                     Pomp.order(:id)
                   end
  end
end