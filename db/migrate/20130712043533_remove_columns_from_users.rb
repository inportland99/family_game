class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :xp
  	remove_column :users, :xp_used
  	remove_column :users, :credits
  	remove_column :users, :rank
  	remove_column :users, :role

  	add_column :users, :admin, :boolean
  	add_column :users, :student_id, :integer
  end
end
