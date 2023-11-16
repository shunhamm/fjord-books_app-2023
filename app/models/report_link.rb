# frozen_string_literal: true

class ReportLink < ApplicationRecord
  belongs_to :mentioned_report, class_name: 'Report', inverse_of: :incoming_mentions
  belongs_to :mentioning_report, class_name: 'Report', inverse_of: :outgoing_mentions

  validates :mentioned_report, uniqueness: { scope: :mentioning_report }
end
