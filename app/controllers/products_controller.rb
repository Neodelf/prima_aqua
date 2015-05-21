class ProductsController < ApplicationController
  def index
    type = params[:type] || 'cup'
    @products = Category.find_by_slug(type).products
    @categories = Category.all
    render 'products/index'
  end
end
