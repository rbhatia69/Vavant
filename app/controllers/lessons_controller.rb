class LessonsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]

  def index
    @course_id   = params[:course_id]
    @course_title = params[:course_title]
    @lessons = Lesson.lessons_by_courses(params[:course_id])
  end

  def associate_material
    @lesson = Lesson.find(params[:lesson_id])
    materials = Array.new(1)
    materials[0] = params[:material_id]
    @lesson.material_ids = materials

    if @lesson.save
      redirect_to(edit_lesson_path(@lesson), :notice => 'Material successfully associated.')
    else
      redirect_to(edit_lesson_path(@lesson))
    end
  end

  def show
      @lesson = Lesson.find(params[:id])
  end

  def display_lesson
    @lesson = Lesson.find(params[:lesson_id])
    @lessons = nil

    if (params.has_key?(:course_id))
      course = Course.find(params[:course_id])
      @lessons = course.lessons
    end
  end

  def new
    @lesson = Lesson.new
    @lesson.course_id = params[:course_id]
    @course = Course.find(params[:course_id])
  end

  def edit
    @lesson = Lesson.find(params[:id])
    @course = Course.find(@lesson.course_id)
  end

  def create
    @lesson = Lesson.new(params[:lesson])

    if @lesson.save
      @course = Course.find(@lesson.course_id)
      redirect_to(courses_showdetail_path(@course), :notice => 'Lesson was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @lesson = Lesson.find(params[:id])

    if @lesson.update_attributes(params[:lesson])
      @course = Course.find(@lesson.course_id)
      redirect_to(courses_showdetail_path(@course), :notice => 'Lesson was successfully updated.')
    else
      render :action => "edit"
    end

  end

  def destroy
    @lesson = Lesson.find(params[:id])
    @course = Course.find(@lesson.course_id)
    @lesson.destroy
    redirect_to(courses_showdetail_path(@course), :notice => 'Lesson was deleted.')

  end
end
