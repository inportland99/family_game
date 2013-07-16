class Activity < ActiveRecord::Base
  attr_accessible :description, :name, :activity_xp, :active, :category
  has_many :points, dependent: :destroy
end
