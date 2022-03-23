class Api::V1::Users::RegistrationController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save

      render json: {
        errors: @user.errors,
        username: @user.email,
      }, status: :created
    else
      render json: {
        errors: @user.errors,
      }, status: :unprocessable_entity
    end
  end

  private #

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :account_id)
  end
end
