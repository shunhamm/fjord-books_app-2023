# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :outgoing_mentions, class_name: 'ReportLink', foreign_key: 'mentioning_report_id', dependent: :destroy, inverse_of: :mentioning_report
  has_many :mentioning_reports, through: :outgoing_mentions, source: :mentioned_report

  has_many :incoming_mentions, class_name: 'ReportLink', foreign_key: 'mentioned_report_id', dependent: :destroy, inverse_of: :mentioned_report
  has_many :mentioned_reports, through: :incoming_mentions, source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  def save_with_mentions
    perform_with_transaction { recreate_mentions if save }
  end

  def update_with_mentions(report_params)
    perform_with_transaction { recreate_mentions if update(report_params) }
  end

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  private

  def perform_with_transaction
    ActiveRecord::Base.transaction do
      yield
    rescue StandardError => e
      Rails.logger.error(e.message)
      raise ActiveRecord::Rollback
    end
  end

  def recreate_mentions
    outgoing_mentions.destroy_all
    extract_mentioning_report_ids.each do |id|
      create_mention(Report.find(id))
    end
  end

  def extract_mentioning_report_ids
    content.scan(%r{http://127.0.0.1:3000/reports/(\d+)}).map(&:first)
  end

  def create_mention(mentioning_report)
    return if id == mentioning_report.id

    mentioning_report.outgoing_mentions.find_or_create_by!(mentioned_report: self)
  end
end
