class CreatePointsSpents < ActiveRecord::Migration
  def change
    create_table :points_spents do |t|
      t.integer :user_id
      t.integer :rewards_id
      t.integer :xp_spent

      t.timestamps
    end
  end
end
