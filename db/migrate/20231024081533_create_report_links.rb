class CreateReportLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :report_links do |t|
      t.references :mentioned_report, foreign_key: { to_table: :reports }
      t.references :mentioning_report, foreign_key: { to_table: :reports }
      t.index %i[mentioned_report_id mentioning_report_id], unique: true, name: 'index_mentioning_mentioned_report_ids'

      t.timestamps
    end
  end
end
