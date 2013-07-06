class RenamePointsToActivities < ActiveRecord::Migration
  def change
  	rename_column :activities, :points, :activity_xp
  end
end
