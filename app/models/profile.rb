class Profile < ActiveRecord::Base
  serialize :education, Array
  serialize :skills, Array
  serialize :experience, Array

  def self.search(search)
    if search
      where("name like ?", "%#{search}%")
    else
  #    find(:all)
    end
  end

end
