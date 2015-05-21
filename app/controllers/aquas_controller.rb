class AquasController < ApplicationController
  skip_before_action :prepare_data, only: :check_price
  def show
    @aqua = Aqua.includes(:aqua_posts, volumes: :prices).find(params[:id])
    @posts = @aqua.aqua_posts
    @prices = @aqua.volumes.map{ |v| [v.value, v.prices.map{|p| p.value}.compact.min] }
  end

  def check_price
    price = OrderService.get_price(params[:aqua_id], params[:volume_id], params[:amount])
    volume = Volume.includes(:prices).find_by(id: params[:volume_id])
    if price.blank?
      tmp_price = volume.prices.first
      price = tmp_price.value.to_f * tmp_price.start_count
    end
    deposit = volume.deposit.to_i
    answer = {price: price, deposit: deposit*(params[:amount].to_i)}
    answer.merge!(amount: tmp_price.start_count) if tmp_price.present?
    render json: answer, status: :ok
  end
end
