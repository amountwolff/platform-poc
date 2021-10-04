require "test_helper"

class PhoneAuthenticationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @phone_authentication = phone_authentications(:one)
  end

  test "should get index" do
    get phone_authentications_url, as: :json
    assert_response :success
  end

  test "should create phone_authentication" do
    assert_difference('PhoneAuthentication.count') do
      post phone_authentications_url, params: { phone_authentication: { authentication_method: @phone_authentication.authentication_method, authentication_url: @phone_authentication.authentication_url, phone: @phone_authentication.phone, platform_tenant_id: @phone_authentication.platform_tenant_id, request_id: @phone_authentication.request_id, session_id: @phone_authentication.session_id, status: @phone_authentication.status } }, as: :json
    end

    assert_response 201
  end

  test "should show phone_authentication" do
    get phone_authentication_url(@phone_authentication), as: :json
    assert_response :success
  end

  test "should update phone_authentication" do
    patch phone_authentication_url(@phone_authentication), params: { phone_authentication: { authentication_method: @phone_authentication.authentication_method, authentication_url: @phone_authentication.authentication_url, phone: @phone_authentication.phone, platform_tenant_id: @phone_authentication.platform_tenant_id, request_id: @phone_authentication.request_id, session_id: @phone_authentication.session_id, status: @phone_authentication.status } }, as: :json
    assert_response 200
  end

  test "should destroy phone_authentication" do
    assert_difference('PhoneAuthentication.count', -1) do
      delete phone_authentication_url(@phone_authentication), as: :json
    end

    assert_response 204
  end
end
