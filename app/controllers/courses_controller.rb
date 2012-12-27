class CoursesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
      @courses = Course.all.page(params[:page])
  end

  def authored
    if (params[:collection_id].nil?)
      @courses = Course.courses_authored_by_user(current_user.id).page(params[:page])
    else
      @courses = Course.courses_authored_by_user_by_collection(current_user.id, params[:collection_id]).page(params[:page])
    end
  end

  def registered
    @registered_courses = Registration.user_registrations(current_user.id).page(params[:page])
  end

  def register
    @register = Registration.new(:user_id => current_user.id, :course_id => params[:course_id])
    if @register.save
        redirect_to(course_path(:id => params[:course_id]), :notice => 'You have successfully registered for the course.')
    end
  end

  def mark_complete
    @completion = Completion.find(:all, :conditions => ["course_id = ? and user_id = ? and lesson_id is NULL", params[:course_id], current_user.id])
    if (@completion.empty?)
      @completion = Completion.new(:user_id => current_user.id, :course_id => params[:course_id], :status => 2)
      if @completion.save
          redirect_to(course_path(:id => params[:course_id]), :notice => 'Course has been mark completed')
      end
    else
      @completion[0].status = 2
      if @completion[0].save
          redirect_to(course_path(:id => params[:course_id]), :notice => 'Course has been mark completed')
      end
    end
  end

  def mark_incomplete
    @completion = Completion.find(:all, :conditions => ["course_id = ? and user_id = ? and lesson_id is NULL", params[:course_id], current_user.id])
    if (@completion.empty?)
      @completion = Completion.new(:user_id => current_user.id, :course_id => params[:course_id], :status => 1)
      if @completion.save
          redirect_to(course_path(:id => params[:course_id]), :notice => 'Course has been marked in progress')
      end
    else
      @completion[0].status = 1
      if @completion[0].save
          redirect_to(course_path(:id => params[:course_id]), :notice => 'Course has been marked in progress')
      end

    end

  end

  def show
    @course = Course.find(params[:id])
    @course.reviews = Review.reviews_by_courses(@course.id)

    @is_user_registered = false
    if (current_user)
      @is_user_registered = Registration.is_user_registered_for_course(@course.id, current_user.id)

      @review = Review.new()
      @review.course_id = @course.id
      @review.user_id = current_user.id

      @all_completion = Completion.completions_by_course_and_user(@course.id, current_user.id)
    end

    @recommended_courses = @course.recommended_courses()
  end

  def showdetail
    @course = Course.find(params[:course_id])
    @course.reviews = Review.reviews_by_courses(@course.id)
  end

  def new
    @course = Course.new

    @collections_list = Collection.find_collection_name_by_user(current_user.id)
  end

  def changestatus
    @course = Course.find(params[:id])
    if (params[:status] == 'U')
      @course.enabled = false
    else
      @course.enabled = true
    end

    if @course.save
        redirect_to(courses_showdetail_path(@course), :notice => 'Course was successfully updated.')
    else
        render :action => "showdetail"
    end

  end

  def edit
    @course = Course.find(params[:id])

    @collections_list = Collection.find_collection_name_by_user(current_user.id)
  end

  def create
    @course = Course.new(params[:course])
    @course.user_id = current_user.id

    if @course.save
        redirect_to(courses_authored_path, :notice => 'Course was successfully created.')
    else
        render :action => "new"
    end

  end

  def update
    @course = Course.find(params[:id])

    if @course.update_attributes(params[:course])
        redirect_to(courses_authored_path, :notice => 'Course was successfully updated.')
    else
        render :action => "new"
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    if (@course.errors.nil?)
      redirect_to(courses_authored_path, :notice => 'Course was successfully deleted.')
    else
      redirect_to(courses_authored_path, :alert => @course.errors[:base][0])
    end
  end
end
