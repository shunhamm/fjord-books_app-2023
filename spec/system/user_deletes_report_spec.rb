# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User deletes the report', type: :system do
  before do
    @user = FactoryBot.create(:user, email: 'testuser@example.com', password: 'password')
    @report = FactoryBot.create(:report, user: @user, title: 'テスト日報', content: 'テストをします。')
  end

  it 'logs in and deletes the report' do
    visit new_user_session_path
    fill_in 'Eメール', with: @user.email
    fill_in 'パスワード', with: @user.password
    click_button 'ログイン'

    expect(page).to have_content('ログインしました。')

    visit report_path(@report.id)

    expect(page).to have_content('日報の詳細')

    click_button 'この日報を削除'

    expect(page).to have_content('日報が削除されました。')
  end
end
