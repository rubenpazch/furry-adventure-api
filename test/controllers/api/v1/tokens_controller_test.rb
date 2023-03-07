# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class TokensControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:one)
      end

      test 'should get the user params' do
        @token = "Bearer #{JsonWebToken.encode(user_id: @user.id)}"
        get api_v1_tokens_url, headers: { 'Authorization' => @token }, as: :json
        assert_response :success
        json_response = JSON.parse(response.body)
        assert_not_nil json_response['username']
      end

      test 'should not get the user params' do
        @token = "Bearer #{JsonWebToken.encode(user_id: @user.id)}"
        get api_v1_tokens_url, headers: { 'Authorization' => "#{@token}s" }, as: :json
        assert_response :unauthorized
      end
    end
  end
end
