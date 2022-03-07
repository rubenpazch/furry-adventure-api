class Api::V1::ProductsController < ApplicationController
  def show 
    render json: @product
  end

  def index 
    render json: Product.all
  end
end
