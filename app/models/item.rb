class Item < ActiveRecord::Base
  belongs_to :bookshelf
  has_many :tags
  has_one :review
  accepts_nested_attributes_for :review
  accepts_nested_attributes_for :tags

  validates :asin, :bookshelf_id, :rank, :status, presence: true

  enum status_list: %i(-- 読みたい いま読んでる 読み終わった 積読)
  enum rank_list: %i(評価しない ★ ★★ ★★★ ★★★★ ★★★★★)
  enum category_list: %i(- 小説 ビジネス 自己啓発 技術 資格)

  def self.find_by_status(status)
    self.where({:status => status}).order('created_at desc')
  end

  def self.search_for_amazon(bookshelf_id, keyword, page = 1)
    if page > 5
      page = 5
    end
    set_amazon
    retry_count = 0
    begin
      res = Amazon::Ecs.item_search(keyword, {:response_group => 'Small, ItemAttributes, Images',
        :item_page => page, :country => 'jp'})
    rescue
      if retry_count <= 5
        retry_count + 1
        retry
      end
      false
    end

    data = {
      :books          => [],
      :current_page   => res.item_page,
      :total_pages    => [res.total_pages, 5].min,
      :total_results  => [res.total_results, 50].min,
      :limit          => 10
    }

    res.items.each do |item|
      element = item.get_element('ItemAttributes')
      asin = item.get('ASIN')
      registered = Item.where({:bookshelf_id => bookshelf_id, :asin => asin}).exists?
      book = {
        :asin             => asin,
        :title            => element.get('Title'),
        :author           => element.get_array('Author').join(', '),
        :publication_date => element.get('PublicationDate'),
        :price            => element.get('ListPrice/FormattedPrice'),
        :registered       => registered,
        :small_image      => item.get('SmallImage/URL'),
        :medium_image     => item.get('MediumImage/URL'),
      }
      data[:books].push(book)
    end

    data
  end

  def self.search_for_amazon_by_asin(asin)
    set_amazon
    retry_count = 0
    begin
      res = Amazon::Ecs.item_lookup(asin, {:response_group => 'Small, ItemAttributes, Images', :country => 'jp'})
    rescue
      if retry_count <= 5
        retry_count + 1
        retry
      end
      false
    end

    book = {}
    res.items.each do |item|
      element = item.get_element('ItemAttributes')
      asin = item.get('ASIN')
      book = {
          :asin             => asin,
          :title            => element.get('Title'),
          :page_url         => 'http://www.amazon.co.jp/dp/' + asin,
          :author           => element.get_array('Author').join(', '),
          :manufacturer     => element.get('Manufacturer'),
          :publication_date => element.get('PublicationDate'),
          :price            => element.get('ListPrice/FormattedPrice'),
          :image            => item.get('LargeImage/URL'),
      }
    end
    book
  end

  def self.set_amazon
    Amazon::Ecs.options = {
      :associate_tag      => ENV['AMAZON_ASSOCIATE_TAG'],
      :AWS_access_key_id  => ENV['AWS_ACCESS_KEY_ID'],
      :AWS_secret_key     => ENV['AWS_SECRET_KEY']
    }
  end
end
