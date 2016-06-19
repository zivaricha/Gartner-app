class Profile < ActiveRecord::Base
  serialize :education, Array
  serialize :skills, Array
  serialize :experience, Array



  scope :by_name, ->(name) { where("name like ?", "%#{name}%") if name.present? }
  scope :by_skills, ->(skills) { where("skills like ?", "%#{skills}%") if skills.present? }

end
