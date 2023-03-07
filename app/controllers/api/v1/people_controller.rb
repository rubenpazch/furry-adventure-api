# frozen_string_literal: true

module Api
  module V1
    class PeopleController < ApplicationController
      before_action :set_person, only: [:show]
      before_action :check_login
      before_action :check_account, only: [:show]
      include ErrorResponseActions
      rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

      def index; end

      def show
        json_string = PersonSerializer.new(@person).serializable_hash.to_json
        render json: json_string, status: :ok
      end

      def create
        @person = Person.new(person_params)
        if @person.save
          render json: @person, status: :created
        else
          render json: @person.errors, status: :unprocessable_entity
        end
      end

      private

      def set_person
        @person = Person.find(params[:id])
      end

      def check_account
        head :forbidden unless @person.account_id == current_user.account_id
      end

      def check_current_user
        @authorization = get_token(request.headers['Authorization'])
        @decodedToken = JsonWebToken.decode(@authorization)
        @user_id = @decodedToken['user_id'] if @decodedToken
        @user = User.find(@user_id)
      end

      def get_token(str)
        str.split(' ').last
      end

      def person_params
        params.require(:person).permit(:first_name,
                                       :last_name,
                                       :doc_id,
                                       :address,
                                       :cell_phone,
                                       :contact_phone,
                                       :district,
                                       :province,
                                       :deparment,
                                       :country,
                                       :nationality,
                                       :age,
                                       :ocupation,
                                       :account_id)
      end
    end
  end
end
