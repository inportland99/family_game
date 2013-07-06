class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :user_id
      t.integer :activity_id
      t.integer :points

      t.timestamps
    end
  end
end
