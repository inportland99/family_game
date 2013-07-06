class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :xp
      t.integer :credits
      t.string :rank

      t.timestamps
    end
  end
end
