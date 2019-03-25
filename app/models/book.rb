class Book < ApplicationRecord
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews

  validates_presence_of :title
  validates_presence_of :pages
  validates_presence_of :publication_year

  def avg_rating
    reviews.average(:rating).to_f.round(1)
  end

  def reviews_count
    reviews.count
  end

  def self.top_rated_books
    Book.joins(:reviews)
        .select('books.*, avg(reviews.rating) as average_rating')
        .group('id')
        .order('average_rating desc, title')
        .limit(3)
  end

  def self.lowest_rated_books
    Book.joins(:reviews)
        .select('books.*, avg(reviews.rating) as average_rating')
        .group('id')
        .order('average_rating asc, title')
        .limit(3)
  end


end
