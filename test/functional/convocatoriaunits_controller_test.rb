require 'test_helper'

class ConvocatoriaunitsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:convocatoriaunits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create convocatoriaunit" do
    assert_difference('Convocatoriaunit.count') do
      post :create, :convocatoriaunit => { }
    end

    assert_redirected_to convocatoriaunit_path(assigns(:convocatoriaunit))
  end

  test "should show convocatoriaunit" do
    get :show, :id => convocatoriaunits(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => convocatoriaunits(:one).to_param
    assert_response :success
  end

  test "should update convocatoriaunit" do
    put :update, :id => convocatoriaunits(:one).to_param, :convocatoriaunit => { }
    assert_redirected_to convocatoriaunit_path(assigns(:convocatoriaunit))
  end

  test "should destroy convocatoriaunit" do
    assert_difference('Convocatoriaunit.count', -1) do
      delete :destroy, :id => convocatoriaunits(:one).to_param
    end

    assert_redirected_to convocatoriaunits_path
  end
end
