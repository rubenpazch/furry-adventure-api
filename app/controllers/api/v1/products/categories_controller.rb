class Api::V1::Products::CategoriesController < ApplicationController
  def index
    render json: { data: Products::Category.all }, status: :ok
  end
end
