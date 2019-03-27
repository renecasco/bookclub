require "rails_helper"

describe 'when a user visits all pages' do
  it "should show a nav bar" do
    author_1 = Author.create(name: "Jane Austen")

    book_1 = Book.create(title: "Pride and Prejudice", pages: 278, publication_year: 1797, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author_1])

    review_1 = book_1.reviews.create(user: "smitty", title: "Mr. Darcy!", rating: 5, description: "Did I mention, Mr. Darcy?!")

    visit books_path

    within ".nav-bar" do
      expect(page).to have_link("Home", href: root_path)
      expect(page).to have_link("All Books", href: books_path)
    end

    visit author_path(author_1)

    within ".nav-bar" do
      expect(page).to have_link("Home", href: root_path)
      expect(page).to have_link("All Books", href: books_path)
    end
  end
end
