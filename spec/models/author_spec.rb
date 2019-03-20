require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :name}
    #validates name is case insensitive and unique
  end
  describe 'relationships' do
    it {should have_many :book_authors}
    it {should have_many(:books).through(:book_authors)}
  end
end
