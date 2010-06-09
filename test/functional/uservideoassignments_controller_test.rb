require 'test_helper'

class UservideoassignmentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:uservideoassignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create uservideoassignment" do
    assert_difference('Uservideoassignment.count') do
      post :create, :uservideoassignment => { }
    end

    assert_redirected_to uservideoassignment_path(assigns(:uservideoassignment))
  end

  test "should show uservideoassignment" do
    get :show, :id => uservideoassignments(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => uservideoassignments(:one).to_param
    assert_response :success
  end

  test "should update uservideoassignment" do
    put :update, :id => uservideoassignments(:one).to_param, :uservideoassignment => { }
    assert_redirected_to uservideoassignment_path(assigns(:uservideoassignment))
  end

  test "should destroy uservideoassignment" do
    assert_difference('Uservideoassignment.count', -1) do
      delete :destroy, :id => uservideoassignments(:one).to_param
    end

    assert_redirected_to uservideoassignments_path
  end
end
