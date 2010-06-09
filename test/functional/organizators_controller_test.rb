require 'test_helper'

class OrganizatorsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organizators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create organizator" do
    assert_difference('Organizator.count') do
      post :create, :organizator => { }
    end

    assert_redirected_to organizator_path(assigns(:organizator))
  end

  test "should show organizator" do
    get :show, :id => organizators(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => organizators(:one).to_param
    assert_response :success
  end

  test "should update organizator" do
    put :update, :id => organizators(:one).to_param, :organizator => { }
    assert_redirected_to organizator_path(assigns(:organizator))
  end

  test "should destroy organizator" do
    assert_difference('Organizator.count', -1) do
      delete :destroy, :id => organizators(:one).to_param
    end

    assert_redirected_to organizators_path
  end
end
