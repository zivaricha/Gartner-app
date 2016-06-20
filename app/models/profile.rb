class Profile < ActiveRecord::Base
  serialize :education, Array
  serialize :skills, Array
  serialize :experience, Array

  # query scopes for filtering the data by different parameters
  scope :by_name, ->(name) { where("name like ?", "%#{name}%") if name.present? }
  scope :by_title, ->(title) { where("title like ?", "%#{title}%") if title.present? }
  scope :by_position, ->(position) { where("position like ?", "%#{position}%") if position.present? }
  scope :by_summary, ->(summary) { where("summery like ?", "%#{summary}%") if summary.present? }
  scope :by_skills, ->(skills) { where("skills like ?", "%#{skills}%") if skills.present? }

end
