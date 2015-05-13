class PricesController < ApplicationController
  def index
    @grouped_volumes = Volume.eager_load(:aqua, :prices).order('"aquas"."id"').group_by{ |v| v.value_str }
    @brands = {}
    @grouped_volumes.each_pair do |size, volumes|
      @brands[size] = volumes.map{ |v| v.aqua.name }.uniq.join(', ')
    end
  end

end
