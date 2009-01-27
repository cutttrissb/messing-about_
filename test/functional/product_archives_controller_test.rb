require 'test_helper'

class ProductArchivesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_archives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_archive" do
    assert_difference('ProductArchive.count') do
      post :create, :product_archive => { }
    end

    assert_redirected_to product_archive_path(assigns(:product_archive))
  end

  test "should show product_archive" do
    get :show, :id => product_archives(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => product_archives(:one).id
    assert_response :success
  end

  test "should update product_archive" do
    put :update, :id => product_archives(:one).id, :product_archive => { }
    assert_redirected_to product_archive_path(assigns(:product_archive))
  end

  test "should destroy product_archive" do
    assert_difference('ProductArchive.count', -1) do
      delete :destroy, :id => product_archives(:one).id
    end

    assert_redirected_to product_archives_path
  end
end
