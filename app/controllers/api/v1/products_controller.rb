# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApplicationController
      before_action :set_product, only: %i[show update]
      before_action :check_login, only: %i[create]
      before_action :check_owner, only: %i[update]

      def show
        render json: @product
      end

      def index
        render json: Product.all, status: :ok
      end

      def create
        @product = Product.new(product_params)
        if @product.save
          render json: @product, status: :created
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      def update
        if @product.update(product_params)
          render json: @product
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      private

      def product_params
        params.require(:product).permit(
          :title,
          :price,
          :published,
          :description,
          :slug,
          :sale_price,
          :product_category_id,
          :account_id,
          :slug_collection
        )
      end

      def check_owner
        head :forbidden unless @product.account_id == current_user&.account_id
      end

      def set_product
        @product = Product.find(params[:id])
      end
    end
  end
end
