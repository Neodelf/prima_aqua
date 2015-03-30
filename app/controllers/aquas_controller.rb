class AquasController < ApplicationController
  def show
    @aqua = Aqua.includes(:aqua_posts, volumes: :prices).find(params[:id])
    @posts = @aqua.aqua_posts
    @prices = @aqua.volumes.map{ |v| [v.value, v.prices.map{|p| p.value}.compact.min] }
  end

  def check_price
    price = PriceService.get_price(params[:aqua_id], params[:volume_id], params[:amount])
    render json: {price: price}, status: :ok
  end
end
