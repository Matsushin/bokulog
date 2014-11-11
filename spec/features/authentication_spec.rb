require 'rails_helper'

feature 'Authentication' do
  include FeaturesSpecHelper
  before(:all) do
    create(:user)
  end

  scenario 'sign up with error' do
    visit root_path
    click_link '会員登録'
    within('#new_user') do
      fill_in 'ユーザ名', with: 'test'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'test'
      click_button '登録'
    end

    expect(page).to have_css('div.alert-danger')
  end

  scenario 'sign up' do
    visit root_path
    click_link '会員登録'
    within('#new_user') do
      fill_in 'ユーザ名', with: 'test'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'testtest'
      click_button '登録'
    end

    expect(page).to have_css('div.alert-success')
    new_user = User.order(:id).last
    expect(new_user.username).to eq 'test'

  end

  scenario 'sign in error' do
    visit root_path
    click_link 'ログイン'
    within('#new_user') do
      fill_in 'ユーザ名', with: 'test'
      fill_in 'パスワード', with: 'testtest'
      click_button 'ログイン'
    end

    expect(page).to have_css('div.alert-danger')
  end

  scenario 'sign in' do
    visit root_path
    click_link 'ログイン'
    within('#new_user') do
      fill_in 'ユーザ名', with: 'test1'
      fill_in 'パスワード', with: 'testtest'
      click_button 'ログイン'
    end

    expect(page).to have_css('div.alert-success')
    expect(current_path).to eq user_path(1)
  end

  scenario 'sign out' do
    create(:user)
    sign_in_as_user(User.order(:id).last, 'testtest')
    click_link 'ログアウト'
    expect(page).to have_css('div.alert-success')
    expect(current_path).to eq root_path
  end
end