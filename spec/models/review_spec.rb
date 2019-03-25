require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :user}
    it {should validate_presence_of :title}
    it {should validate_presence_of :description}
    it {should validate_numericality_of(:rating).is_greater_than_or_equal_to(1)}
    it {should validate_numericality_of(:rating).is_less_than_or_equal_to(5)}
  end

  describe 'relationships' do
    it {should belong_to :book}
  end

  describe 'class methods' do
    it "should calculate statistics for all books - user with most reviews" do
      author_1 = Author.create(name: "Jane Austen")
      author_2 = Author.create(name: "J.R.R. Tolkein")
      author_3 = Author.create(name: "Steve Martin")

      book_1 = Book.create(title: "Pride and Prejudice", pages: 278, publication_year: 1797, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author_1])
      book_2 = Book.create(title: "The Hobbit", pages: 478, publication_year: 1932, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author_2])
      book_3 = Book.create(title: "Shop Girl", pages: 150, publication_year: 2010, cover_art: "https://images-na.ssl-images-amazon.com/images/I/41PG42Z25GL._SX323_BO1,204,203,200_.jpg", authors: [author_3, author_1])
      book_4 = Book.create(title: "Sense and Sensibility", pages: 190, publication_year: 1811, cover_art: "https://images-na.ssl-images-amazon.com/images/I/41PG42Z25GL._SX323_BO1,204,203,200_.jpg", authors: [author_1])
      book_5 = Book.create(title: "Emma", pages: 100, publication_year: 1860, cover_art: "https://images-na.ssl-images-amazon.com/images/I/41PG42Z25GL._SX323_BO1,204,203,200_.jpg", authors: [author_1])
      book_6 = Book.create(title: "Lord of The Rings", pages: 700, publication_year: 1954, cover_art: "https://images-na.ssl-images-amazon.com/images/I/41PG42Z25GL._SX323_BO1,204,203,200_.jpg", authors: [author_2])
      book_7 = Book.create(title: "Shop Girl 1", pages: 150, publication_year: 2010, cover_art: "https://images-na.ssl-images-amazon.com/images/I/41PG42Z25GL._SX323_BO1,204,203,200_.jpg", authors: [author_3, author_1])
      book_8 = Book.create(title: "Fellowship of the Rings", pages: 658, publication_year: 1954, cover_art: "https://images-na.ssl-images-amazon.com/images/I/41PG42Z25GL._SX323_BO1,204,203,200_.jpg", authors: [author_3, author_1])


      review_1 = book_1.reviews.create(user: "smitty", title: "Mr. Darcy!", rating: 5, description: "Did I mention, Mr. Darcy?!")
      review_2 = book_1.reviews.create(user: "renny", title: "boo hoo hoo", rating: 5, description: "it wasn't funny!")
      review_3 = book_1.reviews.create(user: "renny_2", title: "Gold Diggers!", rating: 5, description: "Get a job! Even though I know you are not allowed to work.")
      review_4 = book_3.reviews.create(user: "smitty", title: "Furry Feet!", rating: 2, description: "I can see why this is a classic!")
      review_5 = book_3.reviews.create(user: "renny", title: "novel was too short?", rating: 1, description: "That's a lot of pages for short people")
      review_6 = book_2.reviews.create(user: "smitty_1", title: "novel was too short?", rating: 1, description: "That's a long novel for short people")
      review_7 = book_4.reviews.create(user: "smitty_1", title: "novel was too short?", rating: 2, description: "That's a long novel for short people")
      review_8 = book_5.reviews.create(user: "renny_5", title: "novel was too short?", rating: 3, description: "That's a long novel for short people")
      review_9 = book_6.reviews.create(user: "renny_6", title: "novel was too short?", rating: 4, description: "That's a long novel for short people")
      review_10 = book_7.reviews.create(user: "renny_1", title: "novel was too short?", rating: 3, description: "That's a long novel for short people")
      review_11 = book_7.reviews.create(user: "renny", title: "novel was too short?", rating: 2, description: "That's a long novel for short people")
      review_12 = book_8.reviews.create(user: "smitty", title: "novel was too short?", rating: 5, description: "That's a long novel for short people")
      review_13 = book_8.reviews.create(user: "renny", title: "novel was too short?", rating: 4, description: "That's a long novel for short people")

      expect(Review.users_with_most_reviews[0].user).to eq('renny')
      expect(Review.users_with_most_reviews[0].count).to eq(4)

      expect(Review.users_with_most_reviews[1].user).to eq('smitty')
      expect(Review.users_with_most_reviews[1].count).to eq(3)

      expect(Review.users_with_most_reviews[2].user).to eq('smitty_1')
      expect(Review.users_with_most_reviews[2].count).to eq(2)


    end
  end
end
