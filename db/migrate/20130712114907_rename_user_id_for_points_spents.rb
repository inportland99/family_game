class RenameUserIdForPointsSpents < ActiveRecord::Migration
  def change
  	rename_column :points_spents, :user_id, :student_id
  end
end
