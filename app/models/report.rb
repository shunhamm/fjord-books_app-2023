# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :mentioned_links, foreign_key: 'mentioned_report_id', dependent: :destroy, inverse_of: :mentioned_report
  has_many :mentioning_reports, through: :mentioned_by_reports, source: :mentioning_report
  has_many :mentions_to_reports, class_name: 'ReportLink', foreign_key: 'mentioning_report_id', dependent: :destroy, inverse_of: :mentioning_report
  has_many :mentioned_reports, through: :mentions_to_reports, source: :report

  validates :title, presence: true
  validates :content, presence: true

  def create_report_link
    mentioned_links.destroy_all
    mentioning_report_ids = content.scan(%r{http://127.0.0.1:3000/reports/(\d+)})
    return if mentioning_report_ids.empty?

    mentioning_report_ids.each do |id|
      mentioning_report = Report.find(id[0].to_i)
      link(mentioning_report)
    end
  end

  def link(mentioning_report)
    return if self == mentioning_report

    mentioned_links.find_or_create_by!(mentioning_report_id: mentioning_report.id)
  end

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def mentioning_reports
    mentioned_links.order(:id).presence
  end

  def mentioned_reports
    my_mentioned_links.order(:id).presence
  end
end
