require 'test_helper'

class WalleventsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wallevents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wallevent" do
    assert_difference('Wallevent.count') do
      post :create, :wallevent => { }
    end

    assert_redirected_to wallevent_path(assigns(:wallevent))
  end

  test "should show wallevent" do
    get :show, :id => wallevents(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => wallevents(:one).to_param
    assert_response :success
  end

  test "should update wallevent" do
    put :update, :id => wallevents(:one).to_param, :wallevent => { }
    assert_redirected_to wallevent_path(assigns(:wallevent))
  end

  test "should destroy wallevent" do
    assert_difference('Wallevent.count', -1) do
      delete :destroy, :id => wallevents(:one).to_param
    end

    assert_redirected_to wallevents_path
  end
end
