class Api::V1::Products::CategoriesController < ApplicationController
  def index
    @categories = Products::Category.all
    render jsonapi: @categories,
           include: [:product_category_images],
           status: :ok
  end
end
