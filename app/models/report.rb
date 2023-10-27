# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :report_links, dependent: :destroy
  has_many :to_reports, through: :report_links, source: :to_report
  has_many :my_report_links, class_name: 'ReportLink', foreign_key: 'to_report_id', dependent: :destroy
  has_many :reports, through: :my_report_links, source: :report

  validates :title, presence: true
  validates :content, presence: true

  def link(to_report)
    return if self == to_report

    report_links.find_or_create_by(to_report_id: to_report.id)
  end

  def unlink(to_report)
    report_link_to = report_links.find_by(to_report_id: to_report.id)
    report_link_to&.destroy
  end

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end
end
