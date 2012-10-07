class Course < ActiveRecord::Base
  ## relationships
  belongs_to :user
  belongs_to :collection
  belongs_to :language
  has_many :lessons, :dependent => :destroy
  has_many :reviews
  has_many :registrations
  has_attached_file :photo

  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  ## validations
  validates :description, :presence => true
  validates :title, :presence => true, :length => {:in => 5..80}
  validates :user_id, :presence => true
  validates_numericality_of :price
  validates_inclusion_of :price, :in => 0..999
  validates_numericality_of :rating
  validates_inclusion_of :rating, :in => 0..5
  validates_numericality_of :no_of_reviews
  validates_numericality_of :no_of_registrations

  ## accessible attributes
  attr_accessible :collection_id, :description, :enabled, :language_id, :no_of_registrations, :no_of_reviews, :price, :rating, :title, :user_id, :photo

  ## method to set default values
  before_validation :set_default_values
  before_destroy :check_destroy_allowed

  ## make sure upon creation the price, rating is 0 and course is disabled
  def set_default_values
    if self.price.nil?
      self.price = 0.0
    end
    if self.rating.nil?
      self.rating = 0
    end
    if self.enabled.nil?
      self.enabled = false
    end
    if self.no_of_reviews.nil?
      self.no_of_reviews = 0
    end
    if self.no_of_registrations.nil?
      self.no_of_registrations = 0
    end
  end

  ## can't if there are reviews or registrations
  def check_destroy_allowed
    if self.no_of_reviews > 0
      return false
    end
    if self.no_of_registrations > 0
      return false
    end

  end

  def self.active_courses
    return Course.where(:enabled => true)
  end

  def self.courses_by_collection(collection_id)
    return Course.where("enabled = ? and collection_id = ?", true, collection_id)
  end

  def self.courses_authored_by_user(user_id)
    return Course.where("user_id = ?", user_id)
  end

end
