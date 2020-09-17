class ExpensesController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :expense_params

  # GET /expenses
  def index
    @expenses = indexize(Expense)
  end

  # GET /expenses/1
  def show
  end

  # GET /expenses/new
  def new
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses
  def create
    if @expense.save
      redirect_to @expense, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@expense)
      render :new
    end
  end

  # PATCH/PUT /expenses/1
  def update
    if @expense.update(expense_params)
      redirect_to @expense, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@expense)
      render :edit
    end
  end

  # DELETE /expenses/1
  def destroy
    if @expense.destroy
      redirect_to expenses_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@expense)
      redirect_to expenses_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def expense_params
      params.require(:expense).permit(:project_id, :concept, :amount, :fecha, :user_id, :status)
    end
end
