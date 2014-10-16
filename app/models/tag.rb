class Tag < ActiveRecord::Base
  belongs_to :items
  validates :item_id, presence: true
end
