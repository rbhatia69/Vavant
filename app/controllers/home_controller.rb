class HomeController < ApplicationController
  def index
    @applied_filters = ""
    if params[:tag]
      @courses = Course.tagged_with(params[:tag]).where(:enabled => true).order("updated_at DESC").page(params[:page])
      @applied_filters = params[:tag]
    elsif (params[:find_course_by])
        @courses = Course.courses_by_name(params[:find_course_by]).page(params[:page])
        @applied_filters = params[:find_course_by]
    elsif (params[:language_name])
      @courses = Course.courses_by_language(params[:language_name]).page(params[:page])
      @applied_filters = params[:language_name]
    else
      @courses = Course.active_courses().page(params[:page])
    end
  end

  def whatisthis

  end
end
