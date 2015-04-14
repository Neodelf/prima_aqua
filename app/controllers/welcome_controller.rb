class WelcomeController < ApplicationController
  def home; end

  def contacts; end

  def payment; end

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
