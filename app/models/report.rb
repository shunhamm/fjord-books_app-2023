# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :report_links, foreign_key: 'from_report_id'
  has_many :report_links, foreign_key: 'to_report_id'
  has_many :reports, through: :report_links, source: :from_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end
end
