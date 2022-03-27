class Api::V1::Products::CategoriesController < ApplicationController
  before_action :check_login, only: %i[index]
  #before_action :check_owner, only: %i[index]

  def index
    @categories = Products::Category.where(account_id: current_user.account_id)
    render json: @categories.to_json(
             :only => [:id, :title, :description, :slug, :product_count, :icon],
             :include => {
               :product_category_images => { only: [:thumbnail, :original, :product_categories_id] },
             },
           ),
           status: :ok
  end

  private

  def check_owner
    head :forbidden unless @product.account_id == current_user&.account_id
  end
end
