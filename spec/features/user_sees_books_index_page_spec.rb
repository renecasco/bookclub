require 'rails_helper'

RSpec.describe 'When a user visits a book index page' do
  it 'lets them see all book titles in the database' do
    author_1 = Author.create(name: "Jane Austen")
    author_2 = Author.create(name: "J.R.R. Tolkein")
    author_3 = Author.create(name: "Steve Martin")

    book_1 = Book.create(title: "Pride and Prejudice", pages: 278, published_year: 1797, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", author: [author_1])
    book_2 = Book.create(title: "The Hobbit", pages: 478, published_year: 1932, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", author: [author_2])
    book_3 = Book.create(title: "Shop Girl", pages: 150, published_year: 2010, cover_art: "https://images-na.ssl-images-amazon.com/images/I/41PG42Z25GL._SX323_BO1,204,203,200_.jpg", author: [author_3, author_1])

    visit 'books_path'

    expect(page).to have_content(book_1.title)
    expect(page).to have_content(book_1.pages)
    expect(page).to have_content(book_1.published_year)
    expect(page).to have_content(book_1.author)

    expect(page).to have_content(book_2.title)
    expect(page).to have_content(book_2.pages)
    expect(page).to have_content(book_2.published_year)
    expect(page).to have_content(book_2.author)

    expect(page).to have_content(book_3.title)
    expect(page).to have_content(book_3.pages)
    expect(page).to have_content(book_3.published_year)
    expect(page).to have_content(book_3.author)
  end
end