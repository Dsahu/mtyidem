require 'test_helper'

class PaycondsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payconds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paycond" do
    assert_difference('Paycond.count') do
      post :create, :paycond => { }
    end

    assert_redirected_to paycond_path(assigns(:paycond))
  end

  test "should show paycond" do
    get :show, :id => payconds(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => payconds(:one).to_param
    assert_response :success
  end

  test "should update paycond" do
    put :update, :id => payconds(:one).to_param, :paycond => { }
    assert_redirected_to paycond_path(assigns(:paycond))
  end

  test "should destroy paycond" do
    assert_difference('Paycond.count', -1) do
      delete :destroy, :id => payconds(:one).to_param
    end

    assert_redirected_to payconds_path
  end
end
