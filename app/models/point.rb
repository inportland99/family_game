class Point < ActiveRecord::Base
  attr_accessible :activity_id, :xp_earned, :student_id
  belongs_to :student
  belongs_to :activity
  validates_presence_of :activity_id, :student_id, :xp_earned

  after_save :update_xp
  after_update :update_xp
  after_destroy :update_xp

  def update_xp
  	student.update_xp
  end
end
