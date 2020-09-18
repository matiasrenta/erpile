class IncomesController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :income_params

  # GET /incomes
  def index
    @incomes = indexize(Income)
  end

  # GET /incomes/1
  def show
  end

  # GET /incomes/new
  def new
  end

  # GET /incomes/1/edit
  def edit
  end

  # POST /incomes
  def create
    if @income.save
      redirect_to @income, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@income)
      render :new
    end
  end

  # PATCH/PUT /incomes/1
  def update
    if @income.update(income_params)
      redirect_to @income, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@income)
      render :edit
    end
  end

  # DELETE /incomes/1
  def destroy
    if @income.destroy
      redirect_to incomes_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@income)
      redirect_to incomes_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def income_params
      params.require(:income).permit(:project_id, :concept, :amount, :fecha, :user_id, :status)
    end
end
