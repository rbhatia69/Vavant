class Language < ActiveRecord::Base

  validates_uniqueness_of :name

  attr_accessible :name
end
