class Collection < ActiveRecord::Base
  has_many :courses

  validates :name, :presence => true, :length => {:in => 5..80}
  validates :user_id, :presence => true
  validates_uniqueness_of :name, :scope=>:user_id, :case_sensitive => false

  attr_accessible :name, :user_id

  before_destroy :set_courses_correctly

  ## make sure to set the collection_id to nil for all courses associated with this collection
  def set_courses_correctly
    courses = Course.where("collection_id = ?", self.id)
    courses.each do |c|
      c.collection_id = nil
      c.save
    end
  end
end
