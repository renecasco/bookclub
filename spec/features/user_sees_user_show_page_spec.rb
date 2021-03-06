require 'rails_helper'

RSpec.describe "When a user clicks on a user's name for any book review", type: :feature do
  it 'takes them to a user show page' do
    author_1 = Author.create(name: "Jane Austen")
    author_2 = Author.create(name: "J.R.R. Tolkein")
    author_3 = Author.create(name: "Steve Martin")

    book_1 = Book.create(title: "Pride and Prejudice", pages: 278, publication_year: 1797, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author_1])
    book_2 = Book.create(title: "The Hobbit", pages: 478, publication_year: 1932, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author_2])
    book_3 = Book.create(title: "Shop Girl", pages: 150, publication_year: 2010, cover_art: "https://images-na.ssl-images-amazon.com/images/I/41PG42Z25GL._SX323_BO1,204,203,200_.jpg", authors: [author_3, author_1])

    review_1 = book_1.reviews.create(user: "smitty", title: "Mr. Darcy!", rating: 5, description: "Did I mention, Mr. Darcy?!")
    review_2 = book_1.reviews.create(user: "renny", title: "boo hoo hoo", rating: 1, description: "it wasn't funny!")
    review_3 = book_3.reviews.create(user: "smitty", title: "Furry Feet!", rating: 5, description: "I can see why this is a classic!")
    review_4 = book_3.reviews.create(user: "renny_1", title: "novel was too short?", rating: 2, description: "That's a lot of pages for short people")
    review_5 = book_1.reviews.create(user: "renny_2", title: "Gold Diggers!", rating: 2, description: "Get a job! Even though I know you are not allowed to work.")

    visit book_path(book_1)

    within "#user-link-#{review_1.id}" do
      click_on 'smitty'
    end

    expect(current_path).to eq(user_path('smitty'))
    expect(page).to have_content('Mr. Darcy!')
    expect(page).to have_content('Furry Feet!')
    expect(page).to_not have_content('Gold Diggers!')

    expect(page).to have_content("Did I mention, Mr. Darcy?!")
    expect(page).to have_content(5)
    expect(page).to have_content("Pride And Prejudice")
    expect(page).to have_content(review_1.created_at)
    expect(page).to have_css("img[src*='#{book_1.cover_art}']")
  end

  it "allows user to delete a review" do
    author_1 = Author.create(name: "Jane Austen")
    author_2 = Author.create(name: "J.R.R. Tolkein")
    author_3 = Author.create(name: "Steve Martin")

    book_1 = Book.create(title: "Pride and Prejudice", pages: 278, publication_year: 1797, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author_1])
    book_2 = Book.create(title: "The Hobbit", pages: 478, publication_year: 1932, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author_2])
    book_3 = Book.create(title: "Shop Girl", pages: 150, publication_year: 2010, cover_art: "https://images-na.ssl-images-amazon.com/images/I/41PG42Z25GL._SX323_BO1,204,203,200_.jpg", authors: [author_3, author_1])

    review_1 = book_1.reviews.create(user: "smitty", title: "Mr. Darcy!", rating: 5, description: "Did I mention, Mr. Darcy?!")
    review_2 = book_1.reviews.create(user: "renny", title: "boo hoo hoo", rating: 1, description: "it wasn't funny!")
    review_3 = book_3.reviews.create(user: "smitty", title: "Furry Feet!", rating: 5, description: "I can see why this is a classic!")
    review_4 = book_3.reviews.create(user: "renny_1", title: "novel was too short?", rating: 2, description: "That's a lot of pages for short people")
    review_5 = book_1.reviews.create(user: "renny_2", title: "Gold Diggers!", rating: 2, description: "Get a job! Even though I know you are not allowed to work.")

    visit user_path('smitty')

    expect(current_path).to eq(user_path('smitty'))

    within "#delete-review-#{review_1.id}" do
      click_on 'Delete Review'
    end
    expect(page).to_not have_content("Mr. Darcy!")
    expect(page).to have_content("Furry Feet!")
  end

  it "allows user to sort review by date - in ascending or descending order" do
    author_1 = Author.create(name: "Jane Austen")
    author_2 = Author.create(name: "J.R.R. Tolkein")
    author_3 = Author.create(name: "Steve Martin")

    book_1 = Book.create(title: "Pride and Prejudice", pages: 278, publication_year: 1797, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author_1])
    book_2 = Book.create(title: "The Hobbit", pages: 478, publication_year: 1932, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author_2])
    book_3 = Book.create(title: "Shop Girl", pages: 150, publication_year: 2010, cover_art: "https://images-na.ssl-images-amazon.com/images/I/41PG42Z25GL._SX323_BO1,204,203,200_.jpg", authors: [author_3, author_1])

    review_1 = book_1.reviews.create(user: "smitty", title: "Mr. Darcy!", rating: 5, description: "Did I mention, Mr. Darcy?!")
    review_2 = book_1.reviews.create(user: "renny", title: "boo hoo hoo", rating: 1, description: "it wasn't funny!")
    review_3 = book_2.reviews.create(user: "smitty", title: "Furry Feet!", rating: 5, description: "I can see why this is a classic!")
    review_4 = book_3.reviews.create(user: "smitty", title: "novel was too short?", rating: 2, description: "That's a lot of pages for short people")
    review_5 = book_1.reviews.create(user: "renny_1", title: "Gold Diggers!", rating: 2, description: "Get a job! Even though I know you are not allowed to work.")

    visit user_path('smitty')

    expect(current_path).to eq(user_path('smitty'))

    click_on "Sort by Date in Ascending Order"
    expect(all('.reviews')[0]).to have_content("Mr. Darcy!")

    click_on "Sort by Date in Descending Order"
    expect(all('.reviews')[2]).to have_content("Mr. Darcy!")
    expect(all('.reviews')[0]).to have_content("novel was too short?")
  end
end
