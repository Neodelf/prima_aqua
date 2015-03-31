class CoolersController < ApplicationController
  def index
    @coolers = Cooler.all.order(:id)
    if params[:type_construction].present?
      if params[:type_construction] == 'напольные'
        @coolers = @coolers.where('type_construction LIKE ?', '%пол%')
      elsif params[:type_construction] == 'настольные'
        @coolers = @coolers.where('type_construction LIKE ?', '%стол%')
      end
    end
    @tags = Tag.all.includes(:coolers).limit(4)
  end
end
