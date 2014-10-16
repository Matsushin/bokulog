require 'rails_helper'

RSpec.describe Tag, :type => :model do
  describe 'validation' do
    describe '#item_id' do
      it { should validate_presence_of(:item_id) }
    end
  end
end
