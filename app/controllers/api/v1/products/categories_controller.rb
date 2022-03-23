class Api::V1::Products::CategoriesController < ApplicationController
  def index
    @categories = Products::Category.all
    render json: @categories.to_json(
             :only => [:id, :title, :description, :slug, :product_count, :icon],
             :include => {
               :product_category_images => { only: [:thumbnail, :original, :product_categories_id] },
             },
           ),
           status: :ok
  end
end
