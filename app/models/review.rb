class Review < ActiveRecord::Base
  belongs_to :item
  validates :item_id, presence: true

  def self.find_reviews_by_asin(asin)
    self.joins(:item).where('items.asin = "' + asin + '"').order('created_at desc')
  end
end
