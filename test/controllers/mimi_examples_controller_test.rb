require 'test_helper'

class MimiExamplesControllerTest < ActionController::TestCase
  setup do
    @mimi_example = mimi_examples(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mimi_examples)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mimi_example" do
    assert_difference('MimiExample.count') do
      post :create, mimi_example: {  }
    end

    assert_redirected_to mimi_example_path(assigns(:mimi_example))
  end

  test "should show mimi_example" do
    get :show, id: @mimi_example
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mimi_example
    assert_response :success
  end

  test "should update mimi_example" do
    patch :update, id: @mimi_example, mimi_example: {  }
    assert_redirected_to mimi_example_path(assigns(:mimi_example))
  end

  test "should destroy mimi_example" do
    assert_difference('MimiExample.count', -1) do
      delete :destroy, id: @mimi_example
    end

    assert_redirected_to mimi_examples_path
  end
end
