class VolumesController < ApplicationController
  skip_before_action :prepare_data, only: :index
  def index
    aqua = Aqua.find(params[:aqua_id])
    volumes = aqua.volumes.map{|v| "#{v.id}-#{v.value}"}
    render json: { volumes: volumes }
  end
end
