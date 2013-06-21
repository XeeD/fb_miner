require 'test_helper'

class Facebook::PagesControllerTest < ActionController::TestCase
  setup do
    @facebook_page = facebook_pages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facebook_pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facebook_page" do
    assert_difference('Facebook::Page.count') do
      post :create, facebook_page: { fb_id: @facebook_page.fb_id, name: @facebook_page.name, url: @facebook_page.url }
    end

    assert_redirected_to facebook_page_path(assigns(:facebook_page))
  end

  test "should show facebook_page" do
    get :show, id: @facebook_page
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facebook_page
    assert_response :success
  end

  test "should update facebook_page" do
    patch :update, id: @facebook_page, facebook_page: { fb_id: @facebook_page.fb_id, name: @facebook_page.name, url: @facebook_page.url }
    assert_redirected_to facebook_page_path(assigns(:facebook_page))
  end

  test "should destroy facebook_page" do
    assert_difference('Facebook::Page.count', -1) do
      delete :destroy, id: @facebook_page
    end

    assert_redirected_to facebook_pages_path
  end
end
