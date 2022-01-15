class Api::V1::LoginController < ApplicationController
  def create
    @user = User.find_by_email(user_params[:email])
    if @user&.authenticate(user_params[:password])
      render json: {
        token: JsonWebToken.encode(user_id: @user.id),
        username: @user.email,
        email: @user.email,
        first_name: @user.first_name,
        last_name: @user.last_name,
        id: @user.id,
      }
    else
      head :unauthorized
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
