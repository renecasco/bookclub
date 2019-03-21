# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

author_1 = Author.create(name: "Martin Short")
author_2 = Author.create(name: "J.R.R. Tolkein")
author_3 = Author.create(name: "Steve Martin")

book_1 = Book.create(title: "How to Funny", pages: 3, publication_year: 2000, cover_art: "https://images-na.ssl-images-amazon.com/images/I/41PG42Z25GL._SX323_BO1,204,203,200_.jpg", authors: [author_1, author_3])
review_1 = book_1.reviews.create(user: "smitty", title: "Hahaha!", rating: 5, description: "it was actually funny!")
review_2 = book_1.reviews.create(user: "renny", title: "boo hoo hoo", rating: 1, description: "it wasn't funny!")

book_2 = Book.create(title: "The Hobbit", pages: 478, publication_year: 1932, cover_art: "https://images-na.ssl-images-amazon.com/images/I/51wScUt0gZL._SX329_BO1,204,203,200_.jpg", authors: [author_2])
review_3 = book_2.reviews.create(user: "smitty", title: "Furry Feet!", rating: 5, description: "I can see why this is a classic!")
review_4 = book_2.reviews.create(user: "renny", title: "novel was too short?", rating: 2, description: "That's a lot of pages for short people")
