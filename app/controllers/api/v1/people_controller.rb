class Api::V1::PeopleController < ApplicationController
  before_action :set_person, only: [:show]
  before_action :check_login
  before_action :check_account, only: [:show]

  def index
  end

  def show
    json_string = PersonSerializer.new(@person).serializable_hash.to_json
    render json: json_string, status: :ok
  end

  def created
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def check_account
    head :forbidden unless @person.account_id == current_user.account_id
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
