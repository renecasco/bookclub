require 'rails_helper'

RSpec.describe 'When a user visits a book index page' do
  it 'lets them see all book titles in the database' do
    author_1 = Author.create(name: "Jane Austen")
    author_2 = Author.create(name: "J.R.R. Tolkein")
    author_3 = Author.create(name: "Steve Martin")

    book_1 = Book.create(title: "Pride and Prejudice", pages: 278, publication_year: 1797, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author_1])
    book_2 = Book.create(title: "The Hobbit", pages: 478, publication_year: 1932, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author_2])
    book_3 = Book.create(title: "Shop Girl", pages: 150, publication_year: 2010, cover_art: "https://images-na.ssl-images-amazon.com/images/I/41PG42Z25GL._SX323_BO1,204,203,200_.jpg", authors: [author_3, author_1])

    review_1 = book_1.reviews.create(user: "smitty", title: "Mr. Darcy!", rating: 5, description: "Did I mention, Mr. Darcy?!")
    review_2 = book_1.reviews.create(user: "renny", title: "boo hoo hoo", rating: 1, description: "it wasn't funny!")
    review_3 = book_3.reviews.create(user: "smitty_1", title: "Furry Feet!", rating: 5, description: "I can see why this is a classic!")
    review_4 = book_3.reviews.create(user: "renny_1", title: "novel was too short?", rating: 2, description: "That's a lot of pages for short people")
    review_5 = book_1.reviews.create(user: "renny_2", title: "Gold Diggers!", rating: 2, description: "Get a job! Even though I know you are not allowed to work.")

    visit books_path
# binding.pry   
    within "#book-#{book_1.id}" do
      expect(page).to have_content(book_1.title)
      expect(page).to have_content(book_1.pages)
      expect(page).to have_content(book_1.publication_year)
      expect(page).to have_content(book_1.authors[0].name)
      expect(page).to have_content("Average Rating: #{book_1.avg_rating}")
      expect(page).to have_content("Number of Reviews: #{book_1.reviews_count}")
    end

    within "#book-#{book_3.id}" do
      expect(page).to have_content(book_3.title)
      expect(page).to have_content(book_3.pages)
      expect(page).to have_content(book_3.publication_year)
      expect(page).to have_content(book_3.authors[0].name)
      expect(page).to have_content(book_3.authors[1].name)
      expect(page).to have_content("Average Rating: #{book_3.avg_rating}")
      expect(page).to have_content("Number of Reviews: #{book_3.reviews_count}")
    end
  end
end
