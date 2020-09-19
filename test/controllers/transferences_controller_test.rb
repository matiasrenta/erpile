require 'test_helper'

class TransferencesControllerTest < ActionController::TestCase
  setup do
    @transference = transferences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transferences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transference" do
    assert_difference('Transference.count') do
      post :create, transference: { amount: @transference.amount, concept: @transference.concept, from_user_id: @transference.from_user_id, status: @transference.status, to_user_id: @transference.to_user_id }
    end

    assert_redirected_to transference_path(assigns(:transference))
  end

  test "should show transference" do
    get :show, id: @transference
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transference
    assert_response :success
  end

  test "should update transference" do
    patch :update, id: @transference, transference: { amount: @transference.amount, concept: @transference.concept, from_user_id: @transference.from_user_id, status: @transference.status, to_user_id: @transference.to_user_id }
    assert_redirected_to transference_path(assigns(:transference))
  end

  test "should destroy transference" do
    assert_difference('Transference.count', -1) do
      delete :destroy, id: @transference
    end

    assert_redirected_to transferences_path
  end
end
