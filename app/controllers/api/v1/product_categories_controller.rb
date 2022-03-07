class Api::V1::ProductCategoriesController < ApplicationController
  def index 
    render json: Products::Category.all
  end
end
