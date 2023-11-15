# frozen_string_literal: true

require_relative '../rails_helper'

RSpec.describe User, type: :model do
  describe '#name_or_email' do
    let(:user) { FactoryBot.create(:user) }
    let(:no_name_user) { FactoryBot.create(:user, :no_name) }

    it 'returns name if the user has name' do
      expect(user.name_or_email).to be user.name
    end

    it 'returns email if the user dose not have name' do
      expect(no_name_user.name_or_email).to be no_name_user.email
    end
  end
end
