# frozen_string_literal: true

module ReportsHelper
  def display_mentioned_reports(mention)
    link_to "#{mention.mentioned_report.user.name}: #{mention.mentioned_report.title}", mention.mentioned_report
  end
end
