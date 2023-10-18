class AddCommentIdToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :comment_id, :integer
  end
end
