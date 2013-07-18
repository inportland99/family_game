class AddCommentToPoints < ActiveRecord::Migration
  def change
    add_column :points, :comment, :string
  end
end
