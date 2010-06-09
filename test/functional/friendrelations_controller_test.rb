require 'test_helper'

class FriendrelationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:friendrelations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create friendrelation" do
    assert_difference('Friendrelation.count') do
      post :create, :friendrelation => { }
    end

    assert_redirected_to friendrelation_path(assigns(:friendrelation))
  end

  test "should show friendrelation" do
    get :show, :id => friendrelations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => friendrelations(:one).to_param
    assert_response :success
  end

  test "should update friendrelation" do
    put :update, :id => friendrelations(:one).to_param, :friendrelation => { }
    assert_redirected_to friendrelation_path(assigns(:friendrelation))
  end

  test "should destroy friendrelation" do
    assert_difference('Friendrelation.count', -1) do
      delete :destroy, :id => friendrelations(:one).to_param
    end

    assert_redirected_to friendrelations_path
  end
end
