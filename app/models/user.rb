class User < ActiveRecord::Base
  attr_accessible :credits, :name, :rank, :xp, :xp_used
  has_many :points, dependent: :destroy
  has_many :points_spents, dependent: :destroy

  def update_xp
  	xp_total = points.sum(:xp_earned)
	update_column(:xp, xp_total)
  end

  def update_xp_used
  	xp_spent_total = points_spents.sum(:xp_spent)
	update_column(:xp_used, xp_spent_total)
  end

end
