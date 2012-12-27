class User < ActiveRecord::Base
  has_many :courses
  has_many :reviews
  has_many :registrations
  has_many :completions


  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  validates_uniqueness_of :email
  validates_uniqueness_of :username

  def self.find_by_username(username)
    return User.where("username = ?", username)
  end

  def total_sales
    ts = User.find_by_sql("select sum(registrations.price) name from registrations, courses
                             where registrations.course_id = courses.id and courses.user_id = " + self.id.to_s())

    return ts[0][:name]
  end

  def total_comments
    tc = User.find_by_sql("select count(reviews.id) name from reviews, courses
                             where reviews.course_id = courses.id and courses.user_id = " + self.id.to_s())

    return tc[0][:name]
  end

  def total_registered
    tr = User.find_by_sql("select count(registrations.id) name from registrations, courses
                             where registrations.course_id = courses.id and courses.user_id = " + self.id.to_s())

    return tr[0][:name]
  end

  def avg_rating
    ar = User.find_by_sql("select avg(courses.rating) name from courses
                             where courses.user_id = " + self.id.to_s())

    return ar[0][:name]
  end

end
