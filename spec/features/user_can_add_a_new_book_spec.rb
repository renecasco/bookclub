require 'rails_helper'

RSpec.describe 'When a visitor clicks on Add New Book', type: :feature do
  it 'allows visitor to create a new book record' do
    visit books_path

    click_link 'Add New Book'

    expect(current_path).to eq(new_book_path)

    fill_in 'Title', with: 'Babylon by Bus'
    fill_in 'Year Published', with: 2010
    fill_in 'Number of Pages', with: 207
    fill_in 'Author(s)', with: 'Ray Lemoin, Jeff Neumann'
    fill_in 'Cover Art', with: 'https://m.media-amazon.com/images/I/51SXzFQbTZL._AC_UL872_FMwebp_QL65_.jpg'

    click_button 'Create Book'

    new_book = Book.last

    expect(new_book).to eq(book_path(new_book))
    expect(new_book.title).to have_content('Babylon by Bus')
    expect(new_book.publication_year).to have_content(2010)
    expect(new_book.pages).to have_content(207)
    new_book.authors.each do |author|
      expect(new_book.author).to have_content(author.name)
    end
    expect(page).to have_xpath("//img[contains(@src,'#{File.basename(new_book.cover_art)}')]")
  end
end
