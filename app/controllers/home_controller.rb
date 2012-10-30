class HomeController < ApplicationController
  def index
    @applied_filters = ""
    if params[:tag]
      @courses = Course.tagged_with(params[:tag]).where(:enabled => true).order("updated_at DESC").page(params[:page])
      @applied_filters = params[:tag]
    elsif (params[:find_course_by])
        @courses = Course.courses_by_name(params[:find_course_by]).page(params[:page])
        @applied_filters = params[:find_course_by]
    elsif (params[:rating])
      @courses = Course.courses_by_rating(params[:rating]).page(params[:page])
      @applied_filters = params[:rating] + "+ stars"
    elsif (params[:price])
      if (params[:price] == "FREE")
        @courses = Course.courses_by_price(0).page(params[:page])
      else
        @courses = Course.courses_by_price(params[:price]).page(params[:page])
      end
      @applied_filters = "$" + params[:price] + " and up"
    else
      @courses = Course.active_courses().page(params[:page])
    end
  end

  def whatisthis

  end
end
