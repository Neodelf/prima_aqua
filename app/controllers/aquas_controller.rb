class AquasController < ApplicationController
  skip_before_action :prepare_data, only: :check_price
  def show
    @aqua = Aqua.includes(:aqua_posts, volumes: :prices).find(params[:id])
    @posts = @aqua.aqua_posts
    @prices = @aqua.volumes.map{ |v| [v.value, v.prices.map{|p| p.value}.compact.min] }
  end

  def check_price
    price = OrderService.get_price(params[:aqua_id], params[:volume_id], params[:amount])
    deposit = Volume.find_by(id: params[:volume_id]).deposit.to_i
    render json: {price: price, deposit: deposit*(params[:amount].to_i)}, status: :ok
  end
end
