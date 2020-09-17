class ProjectsController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :project_params

  # GET /projects
  def index
    @projects = indexize(Project)
  end

  # GET /projects/1
  def show
  end

  # GET /projects/new
  def new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    if @project.save
      redirect_to @project, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@project)
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      redirect_to @project, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@project)
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    if @project.destroy
      redirect_to projects_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@project)
      redirect_to projects_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:name, :description, :price, :status)
    end
end
