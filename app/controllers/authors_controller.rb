class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
    @author_books = @author.books
  end
end
