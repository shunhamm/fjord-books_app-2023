# frozen_string_literal: true

class ReportLink < ApplicationRecord
  belongs_to :mentioned_report, class_name: 'Report', inverse_of: :mentioned_by_reports
  belongs_to :mentioning_report, class_name: 'Report', inverse_of: :mentions_to_reports

  validates :mentioned_report, uniqueness: { scope: :mentioning_report }
end
