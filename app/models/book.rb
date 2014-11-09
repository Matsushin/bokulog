class Book < ActiveRecord::Base
  has_many :items
  has_many :users, through: :items

  validates :asin, presence: true
  validates :asin, uniqueness: true

  def reviews
    self.items.where('review <> ""').order('created_at desc')
  end

  def resistered_count
    self.items.count
  end

  def has_rank?
    self.items.where('rank <> 0').count > 0
  end

  def rank
    rank_list = self.items.where('rank <> 0').pluck(:rank)
    (rank_list.inject{|sum, n| sum + n} / rank_list.size.to_f).round(2)
  end

  def self.search_for_amazon(keyword, page = 1)
    page = 5 if page > 5

    res = retryable(tries: 5) do
      Amazon::Ecs.item_search(keyword, {:response_group => 'Small, ItemAttributes, Images',
                                      :item_page => page, :country => 'jp'})
    end
    res
  end

  def self.find_or_create_by_asin(asin)
    book = self.find_by_asin(asin)
    if book.nil?
      self.search_for_amazon_by_asin(asin)
    else
      book
    end
  end

  private

  def self.search_for_amazon_by_asin(asin)
    res = retryable(tries: 5) do
      Amazon::Ecs.item_lookup(asin, {:response_group => 'Small, ItemAttributes, Images', :country => 'jp'})
    end
    book = {}
    res.items.each do |item|
      element = item.get_element('ItemAttributes')
      asin = item.get('ASIN')
      book = {
          :asin             => asin,
          :title            => element.get('Title'),
          :author           => element.get_array('Author').join(', '),
          :manufacturer     => element.get('Manufacturer'),
          :publicated_at    => element.get('PublicationDate'),
          :price            => element.get('ListPrice/FormattedPrice'),
          :image            => item.get('LargeImage/URL'),
      }
    end
    self.create(book)
  end
end
