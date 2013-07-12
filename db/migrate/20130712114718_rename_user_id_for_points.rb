class RenameUserIdForPoints < ActiveRecord::Migration
  def change
  	rename_column :points, :user_id, :student_id
  end
end
