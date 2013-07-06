class Point < ActiveRecord::Base
  attr_accessible :activity_id, :xp_earned, :user_id
  belongs_to :user
  belongs_to :activity
  validates_presence_of :activity_id, :user_id, :xp_earned

  after_save :update_xp
  after_update :update_xp
  after_destroy :update_xp

  def update_xp
  	user.update_xp
  end
end
