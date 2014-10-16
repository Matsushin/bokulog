require 'rails_helper'

feature 'Items' do
  include FeaturesSpecHelper
  before(:each) do
    create(:user)
    create(:bookshelf)
    create(:review)
    sign_in_as_user(User.order(:id).last, 'testtest')
  end

  scenario 'search book' do
    fill_in 'keyword', with: 'Rails'
    click_button '検索'

    expect(current_path).to eq search_items_path
    expect(page.html).to include('パーフェクト Ruby on Rails')
  end

  scenario 'show book detail' do
    fill_in 'keyword', with: 'Rails'
    click_button '検索'
    click_link 'パーフェクト Ruby on Rails'

    asin = '4774165166'
    expect(current_path).to eq item_path(asin)
    expect(page.html).to include('￥ 3,110')

  end
end