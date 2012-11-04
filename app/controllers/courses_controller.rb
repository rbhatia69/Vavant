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

  def show
    @course = Course.find(params[:id])
    @course.reviews = Review.reviews_by_courses(@course.id)

    @is_user_registered = false
    if (current_user)
      @is_user_registered = Registration.is_user_registered_for_course(@course.id, current_user.id)

      @review = Review.new()
      @review.course_id = @course.id
      @review.user_id = current_user.id
    end

  end

  def new
    @course = Course.new

    @collections_list = Collection.find_collection_name_by_user(current_user.id)
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

    redirect_to(courses_authored_path, :notice => 'Course was successfully deleted.')
  end
end
