class BooksController < ApplicationController

  def index
    @stats_books = Book.all
    if params[:column]
      @books = Book.sort_books_by(params[:column], params[:direction])
    else
      @books = Book.all
    end
    @authors = Author.all
    @reviews = Review.all

  end

  def show
    @book = Book.find(params[:id])
    @reviews = Review.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.authors = params[:book][:authors].split(",").map do |author|
      Author.find_or_create_by(name: author.titleize.strip)
    end
    @book.save
    redirect_to book_path(@book)
  end

  def destroy
    book = Book.find(params[:id])
    book.delete_reviews(book.reviews)
    book.delete_book_authors(book.book_authors)
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :pages, :publication_year, :cover_art, :author)
  end

end
