class Bookshelf < ActiveRecord::Base
  belongs_to :user
  has_many :items
  validates :user_id, presence: true

  def self.find_user_by_id(id)
    bookshelf = self.find_by(:id => id)
    bookshelf.nil? ? nil : bookshelf.user
  end
end
