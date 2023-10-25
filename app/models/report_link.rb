# frozen_string_literal: true

class ReportLink < ApplicationRecord
  belongs_to :from_report_id, class_name: 'Report'
  belongs_to :to_report_id, class_name: 'Report'

  validates :from_report_id, presence: true
  validates :to_report_id, presence: true
end
