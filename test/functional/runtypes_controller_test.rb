require 'test_helper'

class RuntypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:runtypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create runtype" do
    assert_difference('Runtype.count') do
      post :create, :runtype => { }
    end

    assert_redirected_to runtype_path(assigns(:runtype))
  end

  test "should show runtype" do
    get :show, :id => runtypes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => runtypes(:one).to_param
    assert_response :success
  end

  test "should update runtype" do
    put :update, :id => runtypes(:one).to_param, :runtype => { }
    assert_redirected_to runtype_path(assigns(:runtype))
  end

  test "should destroy runtype" do
    assert_difference('Runtype.count', -1) do
      delete :destroy, :id => runtypes(:one).to_param
    end

    assert_redirected_to runtypes_path
  end
end
