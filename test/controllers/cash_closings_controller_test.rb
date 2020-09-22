require 'test_helper'

class CashClosingsControllerTest < ActionController::TestCase
  setup do
    @cash_closing = cash_closings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cash_closings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cash_closing" do
    assert_difference('CashClosing.count') do
      post :create, cash_closing: { caja_lapile: @cash_closing.caja_lapile, fecha_hora: @cash_closing.fecha_hora, javi_amount: @cash_closing.javi_amount, javi_caja: @cash_closing.javi_caja, javi_percent: @cash_closing.javi_percent, marcos_amount: @cash_closing.marcos_amount, marcos_caja: @cash_closing.marcos_caja, marcos_percent: @cash_closing.marcos_percent, mati_amount: @cash_closing.mati_amount, mati_caja: @cash_closing.mati_caja, mati_percent: @cash_closing.mati_percent, maxi_amount: @cash_closing.maxi_amount, maxi_caja: @cash_closing.maxi_caja, maxi_percent: @cash_closing.maxi_percent, status: @cash_closing.status }
    end

    assert_redirected_to cash_closing_path(assigns(:cash_closing))
  end

  test "should show cash_closing" do
    get :show, id: @cash_closing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cash_closing
    assert_response :success
  end

  test "should update cash_closing" do
    patch :update, id: @cash_closing, cash_closing: { caja_lapile: @cash_closing.caja_lapile, fecha_hora: @cash_closing.fecha_hora, javi_amount: @cash_closing.javi_amount, javi_caja: @cash_closing.javi_caja, javi_percent: @cash_closing.javi_percent, marcos_amount: @cash_closing.marcos_amount, marcos_caja: @cash_closing.marcos_caja, marcos_percent: @cash_closing.marcos_percent, mati_amount: @cash_closing.mati_amount, mati_caja: @cash_closing.mati_caja, mati_percent: @cash_closing.mati_percent, maxi_amount: @cash_closing.maxi_amount, maxi_caja: @cash_closing.maxi_caja, maxi_percent: @cash_closing.maxi_percent, status: @cash_closing.status }
    assert_redirected_to cash_closing_path(assigns(:cash_closing))
  end

  test "should destroy cash_closing" do
    assert_difference('CashClosing.count', -1) do
      delete :destroy, id: @cash_closing
    end

    assert_redirected_to cash_closings_path
  end
end
