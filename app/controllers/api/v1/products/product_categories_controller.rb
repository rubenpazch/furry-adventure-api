class Api::V1::Products::CategoriesController < ApplicationController
  def index 
    render json: Products::Category.all
  end
end
