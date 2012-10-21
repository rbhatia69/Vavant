class HomeController < ApplicationController
  def index
    @courses = Course.active_courses()

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end

  end
end
