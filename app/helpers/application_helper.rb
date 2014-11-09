module ApplicationHelper
  def small_book_image(url)
    url.gsub('.jpg', '._SL75_.jpg')
  end

  def medium_book_image(url)
    url.gsub('.jpg', '._SL160_.jpg')
  end

  def rank_to_star(rank)
    render inline: <<-HAML.strip_heredoc, type: :haml, locals: {rank: rank}
      - 5.times do |index|
        - if index < rank
          %i.fa.fa-star.orange
        - else
          %i.fa.fa-star-o
    HAML
  end
end
