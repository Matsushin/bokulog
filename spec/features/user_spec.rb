require 'rails_helper'

feature 'My page' do
  include FeaturesSpecHelper
  before(:all) do
    create(:user)
    create(:item)
    create(:book)
    sign_in_as_user(User.order(:id).last, 'testtest')
  end

  scenario 'display reading status' do
    item = Item.order(:id).last
    expect(page.html).to include(edit_user_item_path(User.order(:id).last, item))
  end
end