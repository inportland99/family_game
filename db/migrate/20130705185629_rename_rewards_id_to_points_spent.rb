class RenameRewardsIdToPointsSpent < ActiveRecord::Migration
  def change
  	rename_column :points_spents, :rewards_id, :reward_id
  end
end
