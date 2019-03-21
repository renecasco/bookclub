class BooksController < ApplicationController

  def index
    @books = Book.all
    @authors = Author.all
  end

  def show
    @book = Book.find(params[:id])
    @reviews = Review.all
  end

  private

  def book_params
    params.require(:book).permit(:title, :pages, :publication_year, :cover_art, :authors)
  end
end
