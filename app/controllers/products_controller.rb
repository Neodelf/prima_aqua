class ProductsController < ApplicationController
  def cups
    @products = Product.cups
    render 'products/index'
    end
  def plates
    @products = Product.plates
    render 'products/index'
    end
  def mixers
    @products = Product.mixers
    render 'products/index'
  end
end
