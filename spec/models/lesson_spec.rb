require 'spec_helper'

describe Lesson do
  before :each do
    @user = User.create(:email => "admin@vavant.com", :password => "test1234")

    @course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id)
  end

  it "new lesson must require title, description, user_id " do
    lesson = Lesson.create
    lesson.should_not be_valid
  end

  it "new lesson must require title" do
    lesson = Lesson.create(:description => "Testing")
    lesson.should_not be_valid
  end

  it "new lesson must require description" do
    lesson = Lesson.create(:title => "Testing")
    lesson.should_not be_valid
  end

  it "new lesson must require course" do
    lesson = Lesson.create(:title => "Testing", :description => "Testing")
    lesson.should_not be_valid
  end

  it "create a validate lesson" do
    lesson = Lesson.create(:title => "Testing", :description => "Testing", :course_id => @course.id)
    lesson.should be_instance_of Lesson
  end

  it "validate sequence is setup" do
    lesson = Lesson.create(:title => "Testing", :description => "Testing", :course_id => @course.id)
    lesson.sequence.should_not be_nil
  end

  it "make sure lessons can not be destroy if course can not be" do
    course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id)
    lesson = Lesson.create(:title => "Testing", :description => "Testing", :course_id => course.id)
    review = Review.create(:course_id => course.id, :user_id => @user.id, :rating => 5, :comment => 'Good Course')

    lesson.destroy.should eql false
  end


end
