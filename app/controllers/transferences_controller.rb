class TransferencesController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :transference_params

  # GET /transferences
  def index
    @transferences = indexize(Transference)
  end

  # GET /transferences/1
  def show
  end

  # GET /transferences/new
  def new
  end

  # GET /transferences/1/edit
  def edit
  end

  # POST /transferences
  def create
    if @transference.save
      redirect_to @transference, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@transference)
      render :new
    end
  end

  # PATCH/PUT /transferences/1
  def update
    if @transference.update(transference_params)
      redirect_to @transference, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@transference)
      render :edit
    end
  end

  # DELETE /transferences/1
  def destroy
    if @transference.destroy
      redirect_to transferences_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@transference)
      redirect_to transferences_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def transference_params
      params.require(:transference).permit(:concept, :from_user_id, :to_user_id, :amount, :status)
    end
end
