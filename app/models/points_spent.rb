class PointsSpent < ActiveRecord::Base
  attr_accessible :reward_id, :student_id, :xp_spent
  belongs_to :student
  belongs_to :reward
  validates_presence_of :reward_id, :student_id, :xp_spent

  after_save :update_xp_used
  after_update :update_xp_used
  after_destroy :update_xp_used
    
  def update_xp_used
  	student.update_xp_used
  end
end
