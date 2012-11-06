class MaterialsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @materials = Material.material_by_user(current_user.id)
  end

  def show
    @material = Material.find(params[:id])
  end

  def new
    @material = Material.new
    @material.user_id = current_user.id
  end

  def edit
    @material = Material.find(params[:id])
  end

  def create
    @material = Material.new(params[:material])
    if @material.save
        redirect_to(materials_path, :notice => 'Material was successfully created and can be associated with a lesson.')
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
