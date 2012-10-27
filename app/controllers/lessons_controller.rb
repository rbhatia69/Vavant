class LessonsController < ApplicationController
  def index
    @course_id   = params[:course_id]
    @course_title = params[:course_title]
    @lessons = Lesson.lessons_by_courses(params[:course_id])
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

  def new
    @lesson = Lesson.new
    @lesson.course_id = params[:course_id]
  end

  def edit
    @lesson = Lesson.find(params[:id])
  end

  def create
    @lesson = Lesson.new(params[:lesson])

    if @lesson.save
      redirect_to(lessons_path(:course_id => @lesson.course_id, :course_title => @lesson.course.title), :notice => 'Lesson was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @lesson = Lesson.find(params[:id])

    if @lesson.save
      redirect_to(lessons_path(:course_id => @lesson.course_id, :course_title => @lesson.course.title), :notice => 'Lesson was successfully updated.')
    else
      render :action => "edit"
    end

  end

  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy
    redirect_to(lessons_path(:course_id => @lesson.course_id, :course_title => @lesson.course.title), :notice => 'Lesson was deleted.')

  end
end
