require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :pages}
    it {should validate_presence_of :publication_year}
  end

  describe 'relationships' do
    it {should have_many :book_authors}
    it {should have_many(:authors).through(:book_authors)}
    it {should have_many :reviews}
  end

  describe 'instance methods' do
    it "should calculate average rating for a book" do
      author_1 = Author.create(name: "Jane Austen")
      book_1 = Book.create(title: "Pride and Prejudice", pages: 278, publication_year: 1797, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author_1])
      review_1 = book_1.reviews.create(user: "smitty", title: "Mr. Darcy!", rating: 5, description: "Did I mention, Mr. Darcy?!")
      review_2 = book_1.reviews.create(user: "renny", title: "boo hoo hoo", rating: 1, description: "it wasn't funny!")
      review_3 = book_1.reviews.create(user: "renny_2", title: "Gold Diggers!", rating: 2, description: "Get a job! Even though I know you are not allowed to work.")

      expect(book_1.avg_rating).to eq(2.7)
      expect(book_1.reviews_count).to eq(3)
    end
  end
end
