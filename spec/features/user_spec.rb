require 'rails_helper'

feature 'My page' do
  include FeaturesSpecHelper
  before(:all) do
    create(:user)
    create(:bookshelf)
    create(:item)
    sign_in_as_user(User.order(:id).last, 'testtest')
  end

  scenario 'display reading status' do
    item = Item.order(:id).last
    expect(page.html).to include(item.image)
  end
end