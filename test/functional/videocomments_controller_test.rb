require 'test_helper'

class VideocommentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:videocomments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create videocomment" do
    assert_difference('Videocomment.count') do
      post :create, :videocomment => { }
    end

    assert_redirected_to videocomment_path(assigns(:videocomment))
  end

  test "should show videocomment" do
    get :show, :id => videocomments(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => videocomments(:one).to_param
    assert_response :success
  end

  test "should update videocomment" do
    put :update, :id => videocomments(:one).to_param, :videocomment => { }
    assert_redirected_to videocomment_path(assigns(:videocomment))
  end

  test "should destroy videocomment" do
    assert_difference('Videocomment.count', -1) do
      delete :destroy, :id => videocomments(:one).to_param
    end

    assert_redirected_to videocomments_path
  end
end
