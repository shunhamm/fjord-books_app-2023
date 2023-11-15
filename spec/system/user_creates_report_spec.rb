# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User creates a report', type: :system do
  before do
    @user = FactoryBot.create(:user, email: 'testuser@example.com', password: 'password')
  end

  it 'logs in and creates a report' do
    visit new_user_session_path
    fill_in 'Eメール', with: @user.email
    fill_in 'パスワード', with: @user.password
    click_button 'ログイン'

    expect(page).to have_content('ログインしました。')

    visit new_report_path

    expect(page).to have_content('新規作成')

    fill_in 'タイトル', with: 'My Test Report'
    fill_in '内容', with: 'This is a test report.'
    click_button '登録する'

    expect(page).to have_content('My Test Report')
    expect(page).to have_content('This is a test report.')
  end
end
