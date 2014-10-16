require 'rails_helper'

RSpec.describe Bookshelf, :type => :model do
  describe 'validation' do
    describe '#user_id' do
      it { should validate_presence_of(:user_id) }
    end
  end

  describe 'find_user_by_id method' do
    before(:all) {
      create(:user)
      create(:bookshelf)
    }

    context 'incorrect parmeter case' do
      it 'user should be nil' do
        bookshelf_id = 99
        user = Bookshelf.find_user_by_id(bookshelf_id)
        expect(user.nil?).to eq true
      end
    end

    context 'normal case' do
      it 'user should not be nil' do
        bookshelf_id = 1
        user = Bookshelf.find_user_by_id(bookshelf_id)
        expect(user.username).to eq 'test1'
      end
    end
  end
end
