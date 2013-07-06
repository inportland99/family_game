class RenameCreditCostToRewards < ActiveRecord::Migration
  def change
  	rename_column :rewards, :credit_cost, :xp_cost
  end
end
