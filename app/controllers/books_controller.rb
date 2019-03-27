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
    @reviews_avg_rating = @book.avg_rating
    @bottom_three_reviews = @book.sort_reviews_by_rating(:asc, 3)
    @top_three_reviews = @book.sort_reviews_by_rating(:desc, 3)
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
    book.reviews.destroy_all
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :pages, :publication_year, :cover_art, :author)
  end

end
