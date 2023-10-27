# frozen_string_literal: true

class ReportLink < ApplicationRecord
  belongs_to :report
  belongs_to :to_report, class_name: 'Report', foreign_key: 'report_id'

  validates :report_id, presence: true
  validates :to_report_id, presence: true
end
