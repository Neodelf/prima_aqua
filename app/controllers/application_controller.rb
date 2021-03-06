class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :prepare_data

  def prepare_data
    @all_delivery_pages ||= DeliveryPage.all
    @all_aquas ||= Aqua.includes(:volumes).select(:id, :name, :id).order(:id).all
    aqua = @all_aquas.first
    volume = aqua.volumes.first
    @aqua_price = OrderService.get_price(aqua.id, volume.id, 2)
    @deposit = volume.deposit.to_i * 2
    @items = Cooler.includes(:images).select(:id, :title, :price).first(10)
    @items += Accessory.select(:id, :title, :price, :image).first(10)
    @items += Product.select(:id, :title, :price, :image).first(10)
    @actions = Article.where(type: 'promotion').all
  end

end
