require 'mongoid'
require_relative 'models/book'

# Load Mongoid configuration
Mongoid.load!('config/mongoid.yml', :development)

puts "Seeding database..."

# Clear existing data
Book.delete_all
puts "Cleared existing books"

# Sample books data
books_data = [
  {
    title: "To Kill a Mockingbird",
    author: "Harper Lee",
    year: 1960,
    genre: "Fiction"
  },
  {
    title: "1984",
    author: "George Orwell",
    year: 1949,
    genre: "Dystopian Fiction"
  },
  {
    title: "The Great Gatsby",
    author: "F. Scott Fitzgerald",
    year: 1925,
    genre: "Classic Fiction"
  },
  {
    title: "Pride and Prejudice",
    author: "Jane Austen",
    year: 1813,
    genre: "Romance"
  },
  {
    title: "The Catcher in the Rye",
    author: "J.D. Salinger",
    year: 1951,
    genre: "Coming-of-age Fiction"
  },
  {
    title: "The Hobbit",
    author: "J.R.R. Tolkien",
    year: 1937,
    genre: "Fantasy"
  },
  {
    title: "Harry Potter and the Philosopher's Stone",
    author: "J.K. Rowling",
    year: 1997,
    genre: "Fantasy"
  },
  {
    title: "The Lord of the Rings",
    author: "J.R.R. Tolkien",
    year: 1954,
    genre: "Fantasy"
  }
]

# Create books
books_data.each do |book_data|
  book = Book.create!(book_data)
  puts "Created: #{book.title} by #{book.author}"
end

puts "\nSeeding complete! Created #{Book.count} books."
puts "Start the app with: ruby app.rb"
puts "Then visit: http://localhost:4567"
