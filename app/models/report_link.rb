# frozen_string_literal: true

class ReportLink < ApplicationRecord
  belongs_to :mentioned_reports, class_name: 'Report', inverse_of: :report_links
  belongs_to :mentioning_reports, class_name: 'Report', inverse_of: :my_report_links

  validates :mentioned_reports, uniqueness: { scope: :mentioning_reports }
end
