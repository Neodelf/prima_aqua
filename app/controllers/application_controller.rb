class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :prepare_data

  def prepare_data
    @all_delivery_pages ||= DeliveryPage.all
    @all_aquas ||= Aqua.select(:id, :name).all
  end

end
