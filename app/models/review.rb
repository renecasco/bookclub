class Review < ApplicationRecord
  belongs_to :book

  validates_presence_of :user
  validates_presence_of :title
  validates_presence_of :description

  validates :rating, presence: true, numericality: {
   greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
