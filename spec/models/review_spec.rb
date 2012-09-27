require 'spec_helper'

describe Review do
  before :each do
    @user = User.create(:email => "admin@vavant.com", :password => "test1234")

    @course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id)

    @registration = Registration.create(:course_id => @course.id, :user_id => @user.id)

  end

  it "new review must require comment, rating, user_id and course_id " do
    review = Review.create
    review.should_not be_valid
  end

  it "new review must require comment, rating, user_id" do
    review = Review.create(:course_id => @course.id)
    review.should_not be_valid
  end

  it "new review must require comment, rating" do
    review = Review.create(:course_id => @course.id, :user_id => @user.id)
    review.should_not be_valid
  end

  it "new review must require comment" do
    review = Review.create(:course_id => @course.id, :user_id => @user.id, :rating => 1)
    review.should_not be_valid
  end

  it "new review created" do
    review = Review.create(:course_id => @course.id, :user_id => @user.id, :rating => 1, :comment => 'Good Course')
    review.should be_instance_of Review
  end

  it "new review rating can't be greater than 5'" do
    review = Review.create(:course_id => @course.id, :user_id => @user.id, :rating => 6, :comment => 'Good Course')
    review.should_not be_valid
  end

  it "create a review without registration should fail" do
    unregistered_course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id)
    review = Review.create(:course_id => unregistered_course.id, :user_id => @user.id, :rating => 1, :comment => 'Good Course')

    review.should_not be_valid
  end


  it "new review should increment review count in course" do
    review = Review.create(:course_id => @course.id, :user_id => @user.id, :rating => 1, :comment => 'Good Course')
    reviewedCourse = Course.find(@course.id)
    reviewedCourse.no_of_reviews.should eql 1
  end

  it "create two reviews and make sure avg rating for course is correct" do
    review = Review.create(:course_id => @course.id, :user_id => @user.id, :rating => 5, :comment => 'Good Course')
    review = Review.create(:course_id => @course.id, :user_id => @user.id, :rating => 1, :comment => 'Good Course')

    reviewedCourse = Course.find(@course.id)
    reviewedCourse.rating.should eql 3.0
  end

end
