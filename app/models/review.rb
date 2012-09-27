class Review < ActiveRecord::Base
  belongs_to :course

  validates_numericality_of :rating
  validates_inclusion_of :rating, :in => 0..5
  validates :comment, :presence => true
  validates :course_id, :presence => true
  validates :user_id, :presence => true

  attr_accessible :comment, :course_id, :rating, :user_id

  before_create :check_registration

  ## update course rating every time a new review/rating is created
  after_create :update_course_rating_upon_add
  after_destroy :update_course_rating_upon_delete

  ## check to make sure only users who are registered can review
  def check_registration
    registrations = Registration.where("user_id = ? and course_id = ?", self.user_id, self.course_id)
    if (registrations.nil? || registrations.length == 0)
      errors[:name] = "only users who are registered for the course can review the course."
      return false
    end
  end

  ##
  def update_course_rating_upon_add
    course = Course.find(self.course_id)
    if course.no_of_reviews == 0 || course.no_of_reviews.nil?
      course.rating = self.rating
      course.no_of_reviews = 1
    else
      total_rating = course.rating * course.no_of_reviews
      total_rating = total_rating + self.rating
      course.rating = total_rating
      course.no_of_reviews = course.no_of_reviews + 1
      course.rating = course.rating / (course.no_of_reviews)
    end
    course.save
  end

  def update_course_rating_upon_delete
    course = Course.find(self.course_id)
    if course.no_of_reviews == 1
      course.rating = 0
      course.no_of_reviews = 0
    else
      total_rating = course.rating * course.no_of_reviews
      total_rating = total_rating - self.rating
      course.rating = total_rating
      course.no_of_reviews = course.no_of_reviews - 1
      course.rating = course.rating / (course.no_of_reviews)
    end
    course.save
  end

  def self.reviews_by_courses(course_id)
    return Review.where("course_id = ?", course_id)
  end

end
