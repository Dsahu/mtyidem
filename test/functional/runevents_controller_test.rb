require 'test_helper'

class RuneventsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:runevents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create runevent" do
    assert_difference('Runevent.count') do
      post :create, :runevent => { }
    end

    assert_redirected_to runevent_path(assigns(:runevent))
  end

  test "should show runevent" do
    get :show, :id => runevents(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => runevents(:one).to_param
    assert_response :success
  end

  test "should update runevent" do
    put :update, :id => runevents(:one).to_param, :runevent => { }
    assert_redirected_to runevent_path(assigns(:runevent))
  end

  test "should destroy runevent" do
    assert_difference('Runevent.count', -1) do
      delete :destroy, :id => runevents(:one).to_param
    end

    assert_redirected_to runevents_path
  end
end
