class AddCommentIdToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :comment_id, :integer
  end
end
