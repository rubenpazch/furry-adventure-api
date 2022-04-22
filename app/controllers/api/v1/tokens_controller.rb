class Api::V1::TokensController < ApplicationController
  def verify
    @authorization = get_token(request.headers["Authorization"])
    @decodedToken = JsonWebToken.decode(@authorization)
    @user_id = @decodedToken["user_id"] if @decodedToken
    @user = User.find(@user_id)
    @menu = @user.role.profile.menus
    @account = @user.account
    @roles = @user.account.roles

    if @user
      render json: {
        token: JsonWebToken.encode(user_id: @user.id),
        username: @user.email,
        email: @user.email,
        first_name: @user.first_name,
        last_name: @user.last_name,
        id: @user.id,
        menu: @menu,
        account: @account,
        roles: @roles,
      }
    else
      head :unauthorized
    end
  rescue JWT::DecodeError
    head :unauthorized
  end

  private

  def get_token(str)
    str.split(" ").last
  end
end
