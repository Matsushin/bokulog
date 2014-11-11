require 'rails_helper'

RSpec.describe Item, :type => :model do
  describe 'validation' do

    describe '#user_id' do
      it { should validate_presence_of(:user_id) }
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
end
