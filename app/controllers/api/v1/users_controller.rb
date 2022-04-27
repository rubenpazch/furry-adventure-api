class Api::V1::UsersController < ApplicationController
  include Paginable
  include ErrorResponseActions
  before_action :set_user, only: %i[show update destroy]
  before_action :check_login
  before_action :check_owner, only: %i[update destroy show]
  before_action :check_current_user, only: %i[index]
  rescue_from ActiveRecord::RecordNotFound, :with => :resource_not_found

  def show
    json_string = UserSerializer.new(@user).serializable_hash.to_json
    render json: json_string
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head 204
  end

  def index
    @result = User.page(params[:page]).per(params[:items_per_page])
    options = get_links_serializer_options("api_v1_users_path",
                                           @result,
                                           params[:items_per_page])
    json_string = UserSerializer.new(@result, options).serializable_hash.to_json
    render json: json_string
  end

  #def admins
  #  render json: User.all, status: :ok
  #end

  private

  def user_params
    params.require(:user)
      .permit(:email, :first_name, :last_name, :password, :account_id, :role_id)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_owner
    head :resource_not_found unless current_user
    head :forbidden unless @user.id == current_user&.id
  end

  def check_current_user
    @authorization = get_token(request.headers["Authorization"])
    @decodedToken = JsonWebToken.decode(@authorization)
    @user_id = @decodedToken["user_id"] if @decodedToken
    @user = User.find(@user_id)
  end

  def get_token(str)
    str.split(" ").last
  end
end
