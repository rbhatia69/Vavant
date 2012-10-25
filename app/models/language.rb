class Language < ActiveRecord::Base
  belongs_to :course

  validates_uniqueness_of :name

  attr_accessible :name

  def self.used_languages
    return Language.find_by_sql("select distinct name from languages
                                inner join courses on languages.id = courses.language_id
                                where courses.enabled = 't'
                                ")

  end
end
