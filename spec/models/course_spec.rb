require 'spec_helper'

describe Course do
  before :each do
    @user = User.create(:email => "admin@vavant.com", :password => "test1234")
    @collection = Collection.create(:name => 'Test1234', :user_id => @user.id)
  end

  it "new course must require title, description, user_id " do
    course = Course.create
    course.should_not be_valid
  end

  it "new course must require title" do
    course = Course.create(:user_id => @user.id, :description => "Testing")
    course.should_not be_valid
  end

  it "new course must require user" do
    course = Course.create(:title => "Testing", :description => "Testing")
    course.should_not be_valid
  end

  it "new course created successfully" do
    course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id)
    course.should be_instance_of Course
  end

  it "new course should have price as 0" do
    course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id)
    course.price.should eql 0.0
  end

  it "new course should have rating as 0" do
    course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id)
    course.rating.should eql 0.0
  end

  it "new course should be disabled" do
    course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id)
    course.enabled.should eql false
  end

  it "new course should have not be part of a collection" do
    course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id)
    course.collection_id.should eql nil
  end

  it "course rating can't be greater than 5" do
    course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id, :rating => 6)
    course.should_not be_valid
  end

  it "course price can't be greater than 999" do
    course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id, :price => 1000)
    course.should_not be_valid
  end

  it "course price can't be less than 0" do
    course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id, :price => -1)
    course.should_not be_valid
  end

  it "create a valid course" do
    course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id)
    course.price = 11.11
    course.enabled = true
    course.rating = 1
    course.save
    course1 = Course.find(course.id)
    course1.price.should eql 11.11
  end

  it "create a course and collection association" do
    course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id, :collection_id => @collection.id)
    course.collection_id.should eql @collection.id
  end

  it "check for active courses" do
    active_courses = Course.active_courses()
    active_courses.length.should eql 0
  end

  it "check for active courses after enabling a course" do
    course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id)
    course.enabled = true
    course.save

    active_courses = Course.active_courses()
    active_courses.length.should eql 1
  end

  it "make sure lessons destroy on course destroy" do
    course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id)
    lesson = Lesson.create(:title => "Testing", :description => "Testing", :course_id => course.id)

    course.destroy
    lambda{Lesson.find(lesson.id)}.should raise_error(ActiveRecord::RecordNotFound)
  end

end
