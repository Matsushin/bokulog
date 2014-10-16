require 'rails_helper'

feature 'Bookshelf' do
  include FeaturesSpecHelper
  before(:each) do
    create(:user)
    create(:bookshelf)
    @item = create(:item)
    @item.asin = '4774165166'
    @item.save
    sign_in_as_user(User.order(:id).last, 'testtest')
  end

  scenario 'show bookshelf' do
    click_link '本棚'
    item = Item.order(:id).last
    expect(current_path).to eq bookshelf_items_path
    expect(page.html).to include(item.image)
  end

  scenario 'edit bookshelf item' do
    click_link '本棚'
    find("div.item-area a:eq(1)").click
    expect(current_path).to eq edit_bookshelf_item_path(@item)

    within('.simple_form') do
      select '積読', from: '読書状況'
      select '★★', from: '評価'
      select '技術', from: 'カテゴリ'
      fill_in 'レビュー', with: 'レビューテスト'
      fill_in 'タグ1', with: 'タグテスト1'
      fill_in 'タグ2', with: 'タグテスト2'
      click_button '編集'
    end

    new_review = Review.order(:id).last
    new_tag = Tag.order(:id).first
    item = Item.order(:id).last
    expect(item.category_id).to eq 4
    expect(new_review.body).to eq 'レビューテスト'
    expect(new_tag.name).to eq 'タグテスト1'
    expect(Tag.count).to eq 5

    expect(current_path).to eq bookshelf_items_path
  end

end