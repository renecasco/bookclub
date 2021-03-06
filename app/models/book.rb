class Book < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :reviews, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates_presence_of :pages
  validates_presence_of :publication_year

  before_save {
    if self.title
      self.title = self.title.titleize
    end
  }
  before_save {
    if self.cover_art == ""
      self.cover_art = "https://b.kisscc0.com/20180813/aq/kisscc0-hardcover-book-cover-computer-icons-reading-book-generic-standing-5b712c2ad3cf24.5317387715341435308676.png"
    end
  }

  def avg_rating
    reviews.average(:rating).to_f.round(1)
  end

  def reviews_count
    reviews.count
  end

  def self.top_rated_books
      Book.sort_books_by("average_rating", "DESC", 3)
  end

  def self.lowest_rated_books
    Book.sort_books_by("average_rating", "ASC", 3)
  end

  def self.sort_books_by(column, direction, number = Book.count)
    Book.joins(:reviews)
    .select('books.*, avg(reviews.rating) as average_rating, count(reviews) as reviews_count')
    .group("id")
    .order("#{column} #{direction}, title")
    .limit(number)
  end

  def sort_reviews_by_rating(direction, limits)
    reviews.order(rating: direction).limit(limits)
  end
end
