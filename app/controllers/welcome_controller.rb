class WelcomeController < ApplicationController
  def home
    aqua = Aqua.first
    # gon.price_19 = aqua.prices.where(volume_id: aqua.volumes.where(value: 19).first).pluck(:value).min
    # gon.price_8 = aqua.prices.where(volume_id: aqua.volumes.where(value: 8).first).pluck(:value).min
    # gon.price_6 = aqua.prices.where(volume_id: aqua.volumes.where(value: 6).first).pluck(:value).min
    # gon.price_1 = aqua.prices.where(volume_id: aqua.volumes.where(value: 0.6).first).pluck(:value).min
  end

  def contacts; end

  def payment; end

  def profile
    redirect_to root_path unless current_user
  end

  def orders
    if current_user
      @orders = current_user.orders.order(created_at: :desc)
    else
      redirect_to root_path
    end
  end

  def about
    @posts = CompanyPost.all
  end

  def delivery
    @district = District.search(params[:name])
    gon.district = @district.select(:lon, :lat)
    @district = @district.order(:name).group_by{|u| u.name[0]}
  end

  def events
    @articles = Article.all
    @articles = @articles.where(type: params[:type]) if params[:type].present?
  end

  def events_show
    @event = Article.find(params[:id])
  end

  def check_time
    render json: OrderService.check_date(params[:data])
  end

  def service
  end
end
