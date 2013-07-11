class Reward < ActiveRecord::Base
  attr_accessible :xp_cost, :description, :name, :active
  has_many :points_spent, dependent: :destroy
end
