class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
    @author_books = @author.books
  end

  def destroy
    author = Author.find(params[:id])
    author.delete_books
    author.destroy
    redirect_to books_path
  end

end
