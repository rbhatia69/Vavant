class HomeController < ApplicationController
  def index
    @applied_filters = ""
    if params[:tag]
      @courses = Course.tagged_with(params[:tag]).where(:enabled => true).order("updated_at DESC")
      @applied_filters = params[:tag]
    elsif (params[:find_course_by])
        @courses = Course.courses_by_name(params[:find_course_by])
        @applied_filters = params[:find_course_by]
    else
      @courses = Course.active_courses()
    end


  end
end
