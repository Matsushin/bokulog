module FeaturesSpecHelper
  def sign_in_as_user(user, password = 'testtest')
    visit root_path
    click_link 'ログイン'
    within('#new_user') do
      fill_in 'ユーザ名', with: user.username
      fill_in 'パスワード', with: password
      click_button 'ログイン'
    end
  end
end