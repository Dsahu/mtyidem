require 'test_helper'

class FriendRequestsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:friend_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create friend_request" do
    assert_difference('FriendRequest.count') do
      post :create, :friend_request => { }
    end

    assert_redirected_to friend_request_path(assigns(:friend_request))
  end

  test "should show friend_request" do
    get :show, :id => friend_requests(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => friend_requests(:one).to_param
    assert_response :success
  end

  test "should update friend_request" do
    put :update, :id => friend_requests(:one).to_param, :friend_request => { }
    assert_redirected_to friend_request_path(assigns(:friend_request))
  end

  test "should destroy friend_request" do
    assert_difference('FriendRequest.count', -1) do
      delete :destroy, :id => friend_requests(:one).to_param
    end

    assert_redirected_to friend_requests_path
  end
end
