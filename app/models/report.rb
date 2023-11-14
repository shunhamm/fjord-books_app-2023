# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :report_links, foreign_key: 'from_report_id', dependent: :destroy, inverse_of: :from_report
  has_many :to_reports, through: :report_links, source: :to_report
  has_many :my_report_links, class_name: 'ReportLink', foreign_key: 'to_report_id', dependent: :destroy, inverse_of: :to_report
  has_many :from_reports, through: :my_report_links, source: :report

  validates :title, presence: true
  validates :content, presence: true

  def create_report_link
    report_links.destroy_all
    mentioning_report_ids = content.scan(%r{http://127.0.0.1:3000/reports/(\d+)})
    return if mentioning_report_ids.empty?

    mentioning_report_ids.each do |id|
      to_report = Report.find(id[0].to_i)
      link(to_report)
    end
  end

  def link(to_report)
    return if self == to_report

    report_links.find_or_create_by!(to_report_id: to_report.id)
  end

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def mentioning_reports
    report_links.order(:id).presence
  end

  def mentioned_reports
    my_report_links.order(:id).presence
  end
end
