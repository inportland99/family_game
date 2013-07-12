class AddColumnsToStudents < ActiveRecord::Migration
  def change
  	add_column :students, :xp_gained, :integer, :default => 0
  	add_column :students, :xp_used, :integer, :default => 0
  	add_column :students, :xp_current, :integer, :default => 0
  end
end
