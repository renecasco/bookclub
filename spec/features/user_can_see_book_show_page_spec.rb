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
   expect(page).to have_link(book_1.authors[0].name)
   expect(page).to have_link(book_1.authors[1].name)
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

  it 'they can add a new review' do
    author = Author.create(name: "J.R.R. Tolkein")
    book = Book.create(title: "The Hobbit", pages: 478, publication_year: 1932, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author])

    visit book_path(book)

    click_link 'Add New Review'

    expect(current_path).to eq(new_book_review_path(book))

    fill_in 'User', with: 'smitty_1'
    fill_in 'Title', with: 'Furry Feet!'
    fill_in 'Rating', with: 5
    fill_in 'Description', with: "I can see why this is a classic!"

    click_button  'Create Review'

    new_review = Review.last

    expect(current_path).to eq(book_path(book))
    expect(new_review.book).to eq(book)
    expect(new_review.user).to eq('smitty_1')
    expect(new_review.title).to eq('Furry Feet!')
    expect(new_review.description).to eq('I can see why this is a classic!')
  end

  it "lets them see statistics for selected book" do
    author_1 = Author.create(name: "Jane Austen")
    book_1 = Book.create(title: "Pride and Prejudice", pages: 278, publication_year: 1797, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author_1])

    review_1 = book_1.reviews.create(user: "smitty", title: "Mr. Darcy!", rating: 5, description: "Did I mention, Mr. Darcy?!")
    review_2 = book_1.reviews.create(user: "renny", title: "boo hoo hoo", rating: 3, description: "it wasn't funny!")
    review_3 = book_1.reviews.create(user: "renny_2", title: "Gold Diggers!", rating: 2, description: "Get a job! Even though I know you are not allowed to work.")
    review_4 = book_1.reviews.create(user: "smitty_1", title: "My Favourite Book!", rating: 4, description: "Read it many times and it's great every time.")
    review_5 = book_1.reviews.create(user: "renny_1", title: "Ghastly!", rating: 1, description: "Counldn't get past the first chapter.")

    visit book_path(book_1)

    within ".reviews-statistics" do
      within "#average-rating" do
        expect(page).to have_content("Average Rating: 3.0")
      end

      within "#top-three-reviews" do
        expect(page).to have_content("Top Reviews")
        expect(page).to have_content("Mr. Darcy!")
        expect(page).to have_content("My Favourite Book")
        expect(page).to have_content("boo hoo hoo")

        expect(page).to_not have_content("Ghastly!")
      end

      within "#bottom-three-reviews" do
        expect(page).to have_content("Worst Reviews")
        expect(page).to have_content("Ghastly!")
        expect(page).to have_content("Gold Diggers!")
        expect(page).to have_content("boo hoo hoo")

        expect(page).to_not have_content("Mr. Darcy!")

      end
    end
  end
end
