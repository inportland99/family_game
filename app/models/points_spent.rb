class PointsSpent < ActiveRecord::Base
  attr_accessible :reward_id, :user_id, :xp_spent
  belongs_to :user
  belongs_to :reward
  validates_presence_of :reward_id, :user_id, :xp_spent

  after_save :update_xp_used
  after_update :update_xp_used
  after_destroy :update_xp_used
    
  def update_xp_used
  	user.update_xp_used
  end
end
