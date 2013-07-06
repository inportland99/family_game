class Reward < ActiveRecord::Base
  attr_accessible :xp_cost, :description, :name
  has_many :points_spent
end
