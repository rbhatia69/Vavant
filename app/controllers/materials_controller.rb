class MaterialsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @materials = Material.material_by_user(current_user.id)
    if (params.has_key?(:lesson_id))
      @lesson = Lesson.find(params[:lesson_id])
    else
      @lesson = nil
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
        if (@material.lesson_ids.nil?)
          redirect_to(materials_path, :notice => 'Material was successfully created and can be associated with a lesson.')
        else
          redirect_to(lessons_path(:lesson_id => @material.lesson_ids[0]), :notice => 'Material was successfully created.')
        end
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
