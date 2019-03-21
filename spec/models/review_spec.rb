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
end
