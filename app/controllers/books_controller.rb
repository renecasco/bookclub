class BooksController < ApplicationController

  def index
    @books = Book.all
    @authors = Author.all
  end

end
