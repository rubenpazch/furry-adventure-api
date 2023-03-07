# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationController < ApplicationController
        def create
          @user = User.new(user_params)
          if @user.valid?
            @user.save

            render json: {
              errors: @user.errors,
              username: @user.email
            }, status: :created
          else
            render json: {
              errors: @user.errors
            }, status: :unprocessable_entity
          end
        end

        private

        def user_params
          params.require(:user).permit(:email, :password, :first_name, :last_name, :account_id)
        end
      end
    end
  end
end
