require 'test_helper'

class UserpictureassignmentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:userpictureassignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create userpictureassignment" do
    assert_difference('Userpictureassignment.count') do
      post :create, :userpictureassignment => { }
    end

    assert_redirected_to userpictureassignment_path(assigns(:userpictureassignment))
  end

  test "should show userpictureassignment" do
    get :show, :id => userpictureassignments(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => userpictureassignments(:one).to_param
    assert_response :success
  end

  test "should update userpictureassignment" do
    put :update, :id => userpictureassignments(:one).to_param, :userpictureassignment => { }
    assert_redirected_to userpictureassignment_path(assigns(:userpictureassignment))
  end

  test "should destroy userpictureassignment" do
    assert_difference('Userpictureassignment.count', -1) do
      delete :destroy, :id => userpictureassignments(:one).to_param
    end

    assert_redirected_to userpictureassignments_path
  end
end
