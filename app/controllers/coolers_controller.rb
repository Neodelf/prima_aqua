class CoolersController < ApplicationController
  def index
    @coolers = if params[:type_construction].present?
                 if params[:type_construction] == 'напольные'
                   Cooler.where('type_construction LIKE ?', '%пол%')
                 elsif params[:type_construction] == 'настольные'
                   Cooler.where('type_construction LIKE ?', '%стол%')
                 end
               elsif params[:tag].present?
                 Tag.where(name: params[:tag]).first.coolers
               elsif params[:type_cooling].present?
                 Cooler.where(type_cooling: params[:type_cooling])
               else
                 Cooler.all
               end
    @coolers = if params[:order] == 'price'
                 @coolers.order(:price)
               else
                 @coolers.to_a.sort_by { |cooler| cooler.has_tag?('Выгодно') ? 0 : 1}
               end
    @tags = Tag.all.includes(:coolers).limit(4)
  end

  def show
    @cooler = Cooler.find(params[:id])
  end

  def get_image
    @image = Image.find(params[:id])
  end
end
