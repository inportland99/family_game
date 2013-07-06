class RenamePointsToPoints < ActiveRecord::Migration
  def change
  	rename_column :points, :points, :xp_earned
  end
end
