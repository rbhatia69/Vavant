class MaterialsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @materials = Material.material_by_user(current_user.id)
    if (params.has_key?(:course_id))
      @course = Course.find(params[:course_id])
    else
      @course = nil
    end
  end

  def show
    @material = Material.find(params[:id])
  end

  def new
    @material = Material.new
    @material.user_id = current_user.id
    if (params.has_key?(:lesson_id))
      @material.lesson_ids = params[:lesson_id]
    else
      @material.lesson_ids = nil
    end
  end

  def edit
    @material = Material.find(params[:id])
  end

  def create
    @material = Material.new(params[:material])

    if @material.save
        redirect_to(materials_path, :notice => 'Material was successfully created and can be associated with lessons.')
    else
        render :action => "new"
    end
  end

  def update
    @material = Material.find(params[:id])

    if @material.update_attributes(params[:material])
        redirect_to(materials_path, :notice => 'Material was successfully updated.')
    else
        render :action => "new"
    end

  end

  def destroy
    @material = Material.find(params[:id])
    @material.destroy

    redirect_to(materials_path, :notice => 'Material was successfully deleted.')
  end
end
