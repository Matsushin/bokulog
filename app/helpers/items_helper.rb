module ItemsHelper
  def set_books(res)
    books = []
    res.items.each do |item|
      element = item.get_element('ItemAttributes')
      asin = item.get('ASIN')
      book = {
          :asin             => asin,
          :title            => element.get('Title'),
          :author           => element.get_array('Author').join(', '),
          :manufacturer     => element.get('Manufacturer'),
          :publication_date => element.get('PublicationDate'),
          :price            => element.get('ListPrice/FormattedPrice'),
          :image            => item.get('LargeImage/URL'),
          :small_image      => item.get('SmallImage/URL'),
          :medium_image     => item.get('MediumImage/URL'),
      }
      books.push(book)
    end
    books
  end

  def set_pager(res)
    pager_data = {
        :books          => [],
        :current_page   => res.item_page,
        :total_pages    => [res.total_pages, 5].min,
        :total_results  => [res.total_results, 50].min,
        :limit          => 10
    }
    pager_data
  end
end
