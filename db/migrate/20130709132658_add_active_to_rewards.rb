class AddActiveToRewards < ActiveRecord::Migration
  def change
    add_column :rewards, :active, :boolean,  :default => true
  end
end
