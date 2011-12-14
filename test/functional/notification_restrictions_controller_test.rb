require 'test_helper'

class NotificationRestrictionsControllerTest < ActionController::TestCase
  setup do
    @notification_restriction = notification_restrictions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notification_restrictions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create notification_restriction" do
    assert_difference('NotificationRestriction.count') do
      post :create, notification_restriction: @notification_restriction.attributes
    end

    assert_redirected_to notification_restriction_path(assigns(:notification_restriction))
  end

  test "should show notification_restriction" do
    get :show, id: @notification_restriction.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @notification_restriction.to_param
    assert_response :success
  end

  test "should update notification_restriction" do
    put :update, id: @notification_restriction.to_param, notification_restriction: @notification_restriction.attributes
    assert_redirected_to notification_restriction_path(assigns(:notification_restriction))
  end

  test "should destroy notification_restriction" do
    assert_difference('NotificationRestriction.count', -1) do
      delete :destroy, id: @notification_restriction.to_param
    end

    assert_redirected_to notification_restrictions_path
  end
end
