class Api::V1::ProductsController < ApplicationController
  def show 
    render json: Product.find(params[:id])
  end

  def index 
    render json: Product.all, status: :ok
  end
end
