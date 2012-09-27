require 'spec_helper'

describe Registration do
  before :each do
    @user = User.create(:email => "admin@vavant.com", :password => "test1234")

    @course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id)
  end

  it "new registration must require course and user " do
    registration = Registration.create
    registration.should_not be_valid
  end

  it "new registration must require user_id" do
    registration = Registration.create(:course_id => @course.id)
    registration.should_not be_valid
  end

  it "new registration created" do
    registration = Registration.create(:course_id => @course.id, :user_id => @user.id)
    registration.should be_instance_of Registration
  end

  it "check prices match  between course and registration upon creation" do
    registration = Registration.create(:course_id => @course.id, :user_id => @user.id)
    registration.price.should eql @course.price
  end

  it "check the no_of_registration increase upon creation" do
    registration = Registration.create(:course_id => @course.id, :user_id => @user.id)
    course = Course.find(@course.id)
    course.no_of_registrations.should eql 1
  end

  it "user isn't allowed to register for the same course'" do
    registration = Registration.create(:course_id => @course.id, :user_id => @user.id)
    #registration2 = Registration.create(:course_id => @course.id, :user_id => @user.id)

    #registration2.should eql nil

    lambda{Registration.create(:course_id => @course.id, :user_id => @user.id)}.should raise_error(ActiveRecord::RecordNotUnique)
  end


end
