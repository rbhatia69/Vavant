class Registration < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  validates :course_id, :presence => true
  validates :user_id, :presence => true

  validates_uniqueness_of :user_id, scope: :course_id

  attr_readonly :price
  attr_accessible :course_id, :price, :user_id

  before_create :set_price

  after_create :update_course_registration_upon_add

  # set the price upon creation to be the same price as the course
  def set_price
    course = Course.find(self.course_id)
    self.price = course.price
  end

  # update the no_registrations
  def update_course_registration_upon_add
    course = Course.find(self.course_id)
    if course.no_of_registrations == 0 || course.no_of_registrations.nil?
      course.no_of_registrations = 1
    else
      course.no_of_registrations = course.no_of_registrations + 1
    end
    course.save
  end

end
