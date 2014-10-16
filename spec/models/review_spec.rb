require 'rails_helper'

RSpec.describe Review, :type => :model do
  describe 'validation' do
    describe '#item_id' do
      it { should validate_presence_of(:item_id) }

    end
  end

  describe 'find_reviews_by_asin method' do
    before(:all) do
      create(:item)
      create(:review)
      create(:review)
    end

    context 'incorrect parameter case' do
      it 'reviews should be empty' do
        asin = 'dummy'
        reviews = Review.find_reviews_by_asin(asin)
        expect(reviews.empty?).to eq true
      end
    end

    context 'normal case' do
      it 'reviews should be array' do
        asin = 'test'
        reviews = Review.find_reviews_by_asin(asin)
        expect(reviews.size).to eq 2
        expect(reviews[1].body).to eq 'レビュー2'
      end
    end
  end
end
