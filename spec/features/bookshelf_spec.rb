require 'rails_helper'

feature 'Bookshelf' do
  include FeaturesSpecHelper
  before(:each) do
    create(:user)
    @book = create(:book)
    @book.asin = '4774165166'
    @book.save
    @item = create(:item)
    @item.book_id = Book.last.id
    @item.user_id = User.last.id
    @item.save
    sign_in_as_user(User.order(:id).last, 'testtest')
  end

  scenario 'show bookshelf' do
    click_link '本棚'
    book = Book.order(:id).last
    expect(current_path).to eq user_items_path(User.last)
    expect(page.html).to include(edit_user_item_path(User.last, book))
  end

  scenario 'edit bookshelf item' do
    click_link '本棚'
    find("div.item-area a:eq(1)").click
    expect(current_path).to eq edit_user_item_path(User.last, @item)

    within('.simple_form') do
      select '積読', from: '読書状況'
      select '★★', from: '評価'
      select '技術', from: 'カテゴリ'
      fill_in 'レビュー', with: 'レビューテスト'
      fill_in 'タグ1', with: 'タグテスト1'
      fill_in 'タグ2', with: 'タグテスト2'
      click_button '編集'
    end

    item = Item.order(:id).last
    new_tag = Tag.order(:id).first
    expect(item.category_id).to eq 4
    expect(item.review).to eq 'レビューテスト'
    expect(new_tag.name).to eq 'タグテスト1'
    expect(Tag.count).to eq 5

    expect(current_path).to eq user_items_path(User.last)
  end

end