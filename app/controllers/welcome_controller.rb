class WelcomeController < ApplicationController
  def home; end

  def contacts; end

  def delivery
    @district = District.search(params[:name])
    gon.district = @district.select(:lon, :lat)
    @district = @district.order(:name).group_by{|u| u.name[0]}
  end
end
