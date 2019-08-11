class BooksController < ApplicationController
  def search
    @books = []
    @details = []

    title = params[:title]
    author = params[:author]

    if title.present? && author.present?
      results = RakutenWebService::Books::Book.search({
        title: title,
        author: author,
        hits: 20
      })
    elsif title.present?
      results = RakutenWebService::Books::Book.search({
        title: title,
        hits: 20
      })
    elsif author.present?
      results = RakutenWebService::Books::Book.search({
        author: author,
        hits: 20
      })
    end

    if results.present?
      results.each do |result|
        book = Book.new(read(result))
        detail = result['itemCaption']
        @books << book
        @details << detail 
      end
    end
  end

  private

  def read(result)
    title = result['title']
    author = result['author']
    image_url = result['largeImageUrl']
    url = result['itemUrl']
    isbn = result['isbn']

    {
      title: title,
      author: author,
      image_url: image_url,
      url: url,
      isbn: isbn,
    }
  end
end