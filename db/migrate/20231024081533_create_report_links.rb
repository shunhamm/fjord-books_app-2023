class CreateReportLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :report_links do |t|
      t.references :from_report, foreign_key: { to_table: :reports }
      t.references :to_report, foreign_key: { to_table: :reports }
      t.index %i[from_report_id to_report_id], unique: true

      t.timestamps
    end
  end
end
