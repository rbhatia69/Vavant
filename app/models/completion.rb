class Completion < ActiveRecord::Base
  attr_accessible :course_id, :lesson_id, :status, :user_id

  belongs_to :course
  belongs_to :user
  belongs_to :lesson

  validates_inclusion_of :status, :in => 1..2

  def self.completions_by_course_and_user(course_id, user_id)
    return Completion.where("course_id = ? and user_id = ?", course_id, user_id)
  end

end
