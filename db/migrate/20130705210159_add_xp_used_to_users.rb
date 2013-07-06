class AddXpUsedToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :xp_used, :integer
  end
end
