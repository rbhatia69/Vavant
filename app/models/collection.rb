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

  def self.find_collection_by_name_user(name, user_id)
    return Collection.where("name = ? and user_id = ?", name, user_id)
  end

  def self.find_collection_by_user(user_id)

    stmt = "select cl.name name, cl.id id, count(cr.id) total from collections cl
            left join courses cr on cl.id = cr.collection_id and cl.user_id = " + user_id.to_s() +
            " group by cl.name, cl.id order by cl.name"

    return Collection.find_by_sql(stmt)

  end

  def self.find_collection_name_by_user(user_id)

    stmt = "select name from collections cl where cl.user_id = " + user_id.to_s()

    return Collection.find_by_sql(stmt).map {|i| i.name}

  end

end
