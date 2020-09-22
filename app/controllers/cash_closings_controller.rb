class CashClosingsController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :cash_closing_params

  # GET /cash_closings
  def index
    @cash_closings = indexize(CashClosing)
  end

  # GET /cash_closings/1
  def show
    expenses = indexize(Expense, {collection: Expense.by_cash_closing(@cash_closing.id), no_paginate: true})
    incomes  = indexize(Income, {collection: Income.by_cash_closing(@cash_closing.id), no_paginate: true})
    @expenses_and_incomes = ( expenses + incomes ).sort_by(&:created_at).reverse
  end

  # GET /cash_closings/new
  def new
    @cash_closing.assign_attributes(maxi_percent: 0.25, javi_percent: 0.25, marcos_percent: 0.25, mati_percent: 0.25)
  end

  # GET /cash_closings/1/edit
  def edit
  end

  # POST /cash_closings
  def create
    if @cash_closing.save
      redirect_to @cash_closing, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@cash_closing)
      render :new
    end
  end

  # PATCH/PUT /cash_closings/1
  def update
    if @cash_closing.update(cash_closing_params)
      redirect_to @cash_closing, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@cash_closing)
      render :edit
    end
  end

  # DELETE /cash_closings/1
  def destroy
    if @cash_closing.destroy
      redirect_to cash_closings_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@cash_closing)
      redirect_to cash_closings_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def cash_closing_params
      params.require(:cash_closing).permit(:fecha_hora, :maxi_percent, :javi_percent, :marcos_percent, :mati_percent, :maxi_amount, :javi_amount, :marcos_amount, :mati_amount, :lapile_caja, :maxi_caja, :javi_caja, :marcos_caja, :mati_caja, :status, :user_id)
    end
end
