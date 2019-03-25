require 'rails_helper'

RSpec.describe 'When a visitor clicks on Add New Book', type: :feature do
  it 'allows visitor to create a new book record' do
    visit books_path

    click_link 'Add New Book'

    expect(current_path).to eq(new_book_path)

    fill_in 'Title', with: 'babylon by bus'
    fill_in 'Publication year', with: 2010
    fill_in 'Pages', with: 207
    fill_in 'Authors', with: 'ray lemoin, jeff neumann'
    fill_in 'Cover art', with: ''

    click_on 'Create Book'

    new_book = Book.last

    expect(current_path).to eq(book_path(new_book))

    expect(page).to have_content('Babylon By Bus')
    expect(page).to have_content(2010)
    expect(page).to have_content(207)
    new_book.authors.each do |author|
      expect(page).to have_content("#{author.name}")
    end

    expect(page).to have_xpath("//img[contains(@src,'#{File.basename(new_book.cover_art)}')]")
  end
end
