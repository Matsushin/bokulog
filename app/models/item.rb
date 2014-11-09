class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  has_many :tags
  accepts_nested_attributes_for :tags

  validates :user_id, :rank, :status, presence: true

  enum status_list: %i(-- 読みたい いま読んでる 読み終わった 積読)
  enum rank_list: %i(評価しない ★ ★★ ★★★ ★★★★ ★★★★★)
  enum category_list: %i(- 小説 ビジネス 自己啓発 技術 資格)

  def self.find_by_status(status)
    self.where({:status => status}).order('created_at desc')
  end
end
