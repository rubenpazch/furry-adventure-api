require 'test_helper'

class Api::V1::LoginControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should get JWT token' do
    post api_v1_login_index_url, params: { user: { email: @user.email, password: 'MyString' } }, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_not_nil json_response['token']
    assert_not_nil json_response['username']
  end

  test 'should not get JWT token' do
    post api_v1_login_index_url, params: { user: { email: @user.email, password: 'b@d_pa$$' } }, as: :json
    assert_response :unauthorized
  end
end
