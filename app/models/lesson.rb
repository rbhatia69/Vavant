class Lesson < ActiveRecord::Base
  belongs_to :course
  has_and_belongs_to_many :materials

  validates :description, :presence => true
  validates :title, :presence => true, :length => {:in => 1..80}
  validates :course_id, :presence => true

  attr_accessible :course_id, :description, :sequence, :title, :material_ids

  before_create :set_sequence

  before_destroy :check_destroy_allowed

  ## make sure upon sequence is setup correctly upon creation
  def set_sequence
    maxseq = Lesson.where(:course_id => self.course_id).maximum("sequence")
    if (maxseq.nil?)
      maxseq = 0
    end
    self.sequence = maxseq + 1
  end

  def check_destroy_allowed
    course = Course.find(self.course_id)
    return course.check_destroy_allowed
  end

  def self.lessons_by_courses(course_id)
    return Lesson.where("course_id = ?", course_id)
  end
end
