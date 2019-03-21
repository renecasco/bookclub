require 'rails_helper'

RSpec.describe 'When a user visits a book show page', type: :feature do
  it 'lets them see all the information related to the book' do
   author_1 = Author.create(name: "Martin Short")
   author_3 = Author.create(name: "Steve Martin")

   book_1 = Book.create(title: "How to Funny", pages: 3, publication_year: 2000, cover_art: "https://images-na.ssl-images-amazon.com/images/I/41PG42Z25GL._SX323_BO1,204,203,200_.jpg", authors: [author_1, author_3])

   visit book_path(book_1)

   expect(page).to have_content(book_1.title)
   expect(page).to have_content(book_1.pages)
   expect(page).to have_content(book_1.publication_year)
   expect(page).to have_content(book_1.authors[0].name)
   expect(page).to have_content(book_1.authors[1].name)
   expect(page).to have_xpath("//img[contains(@src,'#{File.basename(book_1.cover_art)}')]")
  end

  it 'lets them see all the reviews for the book' do
    author_1 = Author.create(name: "Martin Short")
    author_2 = Author.create(name: "J.R.R. Tolkein")
    author_3 = Author.create(name: "Steve Martin")

    book_1 = Book.create(title: "How to Funny", pages: 3, publication_year: 2000, cover_art: "https://images-na.ssl-images-amazon.com/images/I/41PG42Z25GL._SX323_BO1,204,203,200_.jpg", authors: [author_1, author_3])
    review_1 = book_1.reviews.create(user: "smitty", title: "Hahaha!", rating: 5, description: "it was actually funny!")
    review_2 = book_1.reviews.create(user: "renny", title: "boo hoo hoo", rating: 1, description: "it wasn't funny!")

    book_2 = Book.create(title: "The Hobbit", pages: 478, publication_year: 1932, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author_2])
    review_3 = book_2.reviews.create(user: "smitty", title: "Furry Feet!", rating: 5, description: "I can see why this is a classic!")
    review_4 = book_2.reviews.create(user: "renny", title: "novel was too short?", rating: 2, description: "That's a lot of pages for short people")

    visit book_path(book_1)

    within "#review-#{review_1.id}" do
      expect(page).to have_content(review_1.user)
      expect(page).to have_content(review_1.title)
      expect(page).to have_content(review_1.rating)
      expect(page).to have_content(review_1.description)
    end

    within "#review-#{review_2.id}" do
      expect(page).to have_content(review_2.user)
      expect(page).to have_content(review_2.title)
      expect(page).to have_content(review_2.rating)
      expect(page).to have_content(review_2.description)
    end

    expect(page).to_not have_selector("#review-#{review_3.id}")
    expect(page).to_not have_selector("#review-#{review_4.id}")
  end
end
