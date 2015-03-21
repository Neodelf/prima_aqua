class PricesController < ApplicationController
  def index
    @grouped_volumes = Volume.includes(:aqua, :prices).group_by{ |v| v.value_str }
    @brands = {}
    @grouped_volumes.each_pair do |size, volumes|
      @brands[size] = volumes.map{ |v| v.aqua.name }.uniq.join(', ')
    end
  end

end
