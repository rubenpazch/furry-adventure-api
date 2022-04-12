class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :check_login
  before_action :check_owner, only: %i[update destroy]
  before_action :check_current_user, only: [:index]

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
    binding.pry
    @result = User.page(params[:page]).per(params[:per_page]).search(params)
    json_string = UserSerializer.new(@result).serializable_hash.to_json
    render json: json_string
  end

  #def admins
  #  render json: User.all, status: :ok
  #end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :account_id, :role_id)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_owner
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
