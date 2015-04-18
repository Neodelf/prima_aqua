class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :prepare_data

  def prepare_data
    @all_delivery_pages ||= DeliveryPage.all
    @all_aquas ||= Aqua.includes(:volumes).select(:id, :name, :id).order(:id).all
    aqua = @all_aquas.first
    @aqua_price = OrderService.get_price(aqua.id, aqua.volumes.first.id, 2)
    @items = Cooler.includes(:images).select(:id, :title, :price).limit(10).to_a
    @items += Accessory.select(:id, :title, :price, :image).first(10)
  end

end
