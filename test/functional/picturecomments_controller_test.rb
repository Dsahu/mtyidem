require 'test_helper'

class PicturecommentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:picturecomments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create picturecomment" do
    assert_difference('Picturecomment.count') do
      post :create, :picturecomment => { }
    end

    assert_redirected_to picturecomment_path(assigns(:picturecomment))
  end

  test "should show picturecomment" do
    get :show, :id => picturecomments(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => picturecomments(:one).to_param
    assert_response :success
  end

  test "should update picturecomment" do
    put :update, :id => picturecomments(:one).to_param, :picturecomment => { }
    assert_redirected_to picturecomment_path(assigns(:picturecomment))
  end

  test "should destroy picturecomment" do
    assert_difference('Picturecomment.count', -1) do
      delete :destroy, :id => picturecomments(:one).to_param
    end

    assert_redirected_to picturecomments_path
  end
end
