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

  def mark_complete
    @completion = Completion.find(:all, :conditions => ["course_id = ? and user_id = ? and lesson_id = ?", params[:course_id], current_user.id, params[:lesson_id]])
    if (@completion.empty?)
      @completion = Completion.new(:user_id => current_user.id, :course_id => params[:course_id], :lesson_id => params[:lesson_id], :status => 2)
      if @completion.save

          redirect_to(lessons_display_lesson_path(:course_id => params[:course_id], :lesson_id => params[:lesson_id]), :notice => 'Lesson has been mark completed')
      end
    else
      @completion[0].status = 2
      if @completion[0].save
          redirect_to(lessons_display_lesson_path(:course_id => params[:course_id], :lesson_id => params[:lesson_id]), :notice => 'Lesson has been mark completed')
      end
    end
  end

  def mark_incomplete
    @completion = Completion.find(:all, :conditions => ["course_id = ? and user_id = ? and lesson_id = ?", params[:course_id], current_user.id, params[:lesson_id]])
    if (@completion.empty?)
      @completion = Completion.new(:user_id => current_user.id, :course_id => params[:course_id], :lesson_id => params[:lesson_id], :status => 1)
      if @completion.save
          redirect_to(lessons_display_lesson_path(:course_id => params[:course_id], :lesson_id => params[:lesson_id]), :notice => 'Lesson has been marked in progress')
      end
    else
      @completion[0].status = 1
      if @completion[0].save
          redirect_to(lessons_display_lesson_path(:course_id => params[:course_id], :lesson_id => params[:lesson_id]), :notice => 'Lesson has been marked in progress')
      end
    end
  end

  def display_lesson
    @lesson = Lesson.find(params[:lesson_id])
    @lessons = nil

    if (params.has_key?(:course_id))
      course = Course.find(params[:course_id])
      @lessons = course.lessons
    end

    @lesson_completion = Completion.find(:all, :conditions => ["course_id = ? and user_id = ? and lesson_id = ?", course.id, current_user.id, @lesson.id])
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
