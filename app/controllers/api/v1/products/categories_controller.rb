# frozen_string_literal: true

module Api
  module V1
    module Products
      class CategoriesController < ApplicationController
        before_action :check_login, only: %i[index]

        def index
          @categories = Products::Category.where(account_id: current_user.account_id)
          render json: Products::ProductCategorySerializer.new(@categories).serializable_hash.to_json,
                 status: :ok
        end

        private

        def check_owner
          head :forbidden unless @product.account_id == current_user&.account_id
        end
      end
    end
  end
end
