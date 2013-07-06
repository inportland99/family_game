class Activity < ActiveRecord::Base
  attr_accessible :description, :name, :activity_xp
  has_many :points
end
