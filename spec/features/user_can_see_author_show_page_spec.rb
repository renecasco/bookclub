require 'rails_helper'

RSpec.describe 'when a user visits an author show page', type: :feature do
  it 'allows them to see all books by that author' do
    author_1 = Author.create(name: "Jane Austen")
    author_2 = Author.create(name: "J.R.R. Tolkein")
    author_3 = Author.create(name: "Steve Martin")

    book_1 = Book.create(title: "Pride and Prejudice", pages: 278, publication_year: 1797, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author_1])
    book_2 = Book.create(title: "The Hobbit", pages: 478, publication_year: 1932, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author_2])
    book_3 = Book.create(title: "Shop Girl", pages: 150, publication_year: 2010, cover_art: "https://images-na.ssl-images-amazon.com/images/I/41PG42Z25GL._SX323_BO1,204,203,200_.jpg", authors: [author_3, author_1])

    visit author_path(author_1)

    within "#book-#{book_1.id}" do
      expect(page).to have_link(book_1.title)
      expect(page).to have_xpath("//img[contains(@src,'#{File.basename(book_1.cover_art)}')]")
      expect(page).to have_content(book_1.pages)
      expect(page).to have_content(book_1.publication_year)
      expect(page).to have_content(book_1.authors[0].name)
    end

    within "#book-#{book_3.id}" do
      expect(page).to have_link(book_3.title)
      expect(page).to have_xpath("//img[contains(@src,'#{File.basename(book_3.cover_art)}')]")
      expect(page).to have_content(book_3.pages)
      expect(page).to have_content(book_3.publication_year)
      expect(page).to have_content(book_3.authors[0].name)
      expect(page).to have_content(book_3.authors[1].name)
    end

    expect(page).not_to have_css("#book-#{book_2.id}")
  end
end
