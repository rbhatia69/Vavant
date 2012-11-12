class User < ActiveRecord::Base
  has_many :courses
  has_many :reviews
  has_many :registrations

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

end
