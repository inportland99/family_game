class Activity < ActiveRecord::Base
  attr_accessible :description, :name, :activity_xp, :active
  has_many :points, dependent: :destroy
end
