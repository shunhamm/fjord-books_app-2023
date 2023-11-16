# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :outgoing_mentions, class_name: 'ReportLink', foreign_key: 'mentioning_report_id', dependent: :destroy, inverse_of: :mentioned_report
  has_many :mentioning_reports, through: :outgoing_mentions, source: :mentioned_report
  has_many :incoming_mentions, class_name: 'ReportLink', foreign_key: 'mentioned_report_id', dependent: :destroy, inverse_of: :mentioning_report
  has_many :mentioned_reports, through: :incoming_mentions, source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  def create_report_link
    outgoing_mentions.destroy_all
    mentioning_report_ids = content.scan(%r{http://127.0.0.1:3000/reports/(\d+)})

    mentioning_report_ids.each do |id|
      mentioning_report = Report.find(id[0].to_i)
      link(mentioning_report)
    end
  end

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  private

  def link(mentioning_report)
    return if id == mentioning_report.id

    mentioning_report.outgoing_mentions.find_or_create_by!(mentioned_report: self)
  end
end
