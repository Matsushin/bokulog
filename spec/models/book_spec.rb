require 'rails_helper'

RSpec.describe Book, :type => :model do
  describe 'validation' do
    describe '#asin' do
      it { should validate_presence_of(:asin) }
    end
  end

  describe 'reviews method' do
    before(:all) do
      create(:book)
      create(:book)
      create(:item)
      create(:item)
      create(:item)
    end

    context 'incorrect parameter case' do
      it 'reviews should be empty' do
        items = Book.last.reviews
        expect(items.empty?).to eq true
      end
    end

    context 'normal case' do
      it 'reviews should be array' do
        items = Book.first.reviews
        expect(items.size).to eq 2
        expect(items.last.review).to eq 'レビュー1'
      end
      end
  end

  describe 'resistered_count method' do
    context 'incorrect parameter case' do
      it 'item count should be empty' do
        expect(Book.last.registered_count).to eq 0
      end
    end

    context 'normal case' do
      it 'item count should be 3' do
        expect(Book.first.registered_count).to eq 3
      end
    end
  end

  describe 'has_rank? method' do
    context 'incorrect paramter case' do
      it {
        expect(Book.last.has_rank?).to eq false
      }
    end

    context 'normal case' do
      it {
        expect(Book.first.has_rank?).to eq true
      }
    end
  end

  describe 'rank method' do
    context 'incorrect paramter case' do
      it {
        expect(Book.last.rank).to eq nil
      }
    end

    context 'normal case' do
      it {
        expect(Book.first.rank).to eq 2.0
      }
    end
  end

  describe 'search_for_amazon method' do
    context 'incorrect parameters case' do
      it 'books should be empty' do
        keyword = 'aaaaaaaaaaaaaaaaaaa'
        amazon_response = Book.search_for_amazon(keyword)
        expect(amazon_response.items.empty?).to eq true
      end
    end

    context 'normal case' do
      it 'books should not be empty' do
        keyword = 'Ruby'
        amazon_response = Book.search_for_amazon(keyword)
        expect(amazon_response.items.size).to eq 10
      end
    end
  end

  describe 'find_or_create_by_asin method' do
    context 'incorrect parameters case' do
      it 'book should be invalid' do
        asin = 'aaaaaaaaaaaaaaaaaa'
        book = Book.find_or_create_by_asin(asin)
        expect(book.valid?).to eq false
      end
    end

    context 'normal case' do
      it 'book id should be 1' do
        asin = 'test1'
        book = Book.find_or_create_by_asin(asin)
        expect(book.id).to eq 1
      end

      it 'book title should be パーフェクト Ruby on Rails' do
        asin = '4774165166'
        book = Book.find_or_create_by_asin(asin)
        expect(book.title).to eq 'パーフェクト Ruby on Rails'
      end
    end
  end

  describe 'search_for_amazon_by_asin method' do
    context 'incorrect parameters case' do
      it 'book should be invalid' do
        asin = 'test'
        book = Book.search_for_amazon_by_asin(asin)
        expect(book.valid?).to eq false
      end
    end

    context 'normal case' do
      it 'book title should be Ruby on Rails 4 アプリケーションプログラミング' do
        asin = '4774164100'
        book = Book.search_for_amazon_by_asin(asin)
        expect(book.title).to eq 'Ruby on Rails 4 アプリケーションプログラミング'
      end
    end
  end
end
