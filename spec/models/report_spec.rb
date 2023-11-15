# frozen_string_literal: true

require_relative '../rails_helper'

RSpec.describe Report, type: :model do
  describe '#editable?' do
    let(:user) { FactoryBot.create(:user) }
    let(:another_user) { FactoryBot.create(:user) }
    let(:report) { FactoryBot.create(:report, user:) }

    it 'returns true if the report belongs to the given user' do
      expect(report.editable?(user)).to be true
    end

    it 'returns false if the report does not belong to the given user' do
      expect(report.editable?(another_user)).to be false
    end
  end
end
