# frozen_string_literal: true

class ReportLink < ApplicationRecord
  belongs_to :from_report, class_name: 'Report', inverse_of: :report_links
  belongs_to :to_report, class_name: 'Report', inverse_of: :my_report_links

  validates :from_report, uniqueness: { scope: :to_report, message: 'その言及関係の組み合わせは既に存在します。' }
end
