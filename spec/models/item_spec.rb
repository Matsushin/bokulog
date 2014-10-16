require 'rails_helper'

RSpec.describe Item, :type => :model do
  describe 'validation' do
    describe '#asin' do
      it { should validate_presence_of(:asin) }
    end

    describe '#bookshelf_id' do
      it { should validate_presence_of(:bookshelf_id) }
    end

    describe '#rank' do
      it { should validate_presence_of(:rank) }
    end

    describe '#status' do
      it { should validate_presence_of(:status) }
    end
  end

  describe 'find_by_status method' do
    before(:all) do
      create(:item)
      create(:item)
    end

    context 'incorrect parameter case' do
      it 'item should be empty' do
        status = 5
        items = Item.find_by_status(status)
        expect(items.empty?).to eq true
      end
    end

    context 'normal case' do
      it 'item should not be empty' do
        status = 1
        items = Item.find_by_status(status)
        expect(items.size).to eq 2
      end
    end
  end

  describe 'search_for_amazon method' do
    context 'incorrect parameters case' do
      it 'books should be empty' do
        bookshelf_id = 1
        keyword = 'aaaaaaaaaaaaaaaaaaa'
        books = Item.search_for_amazon(bookshelf_id, keyword)
        expect(books[:books].empty?).to eq true
      end
    end

    context 'normal case' do
      it 'books should not be empty' do
        bookshelf_id = 1
        keyword = 'Ruby'
        books = Item.search_for_amazon(bookshelf_id, keyword)
        expect(books[:books].size).to eq 10
      end
    end
  end

  describe 'search_for_amazon_by_asin method' do
    context 'incorrect parameters case' do
      it 'book should be empty' do
        asin = 'test'
        book = Item.search_for_amazon_by_asin(asin)
        expect(book.empty?).to eq true
      end
    end

    context 'normal case' do
      it 'book should not be empty' do
        asin = '4774164100'
        book = Item.search_for_amazon_by_asin(asin)
        expect(book[:title]).to eq 'Ruby on Rails 4 アプリケーションプログラミング'
      end
    end
  end
end
