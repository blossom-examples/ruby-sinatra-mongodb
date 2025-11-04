require 'sinatra'
require 'mongoid'
require 'json'
require_relative 'models/book'

# Load Mongoid configuration
Mongoid.load!('config/mongoid.yml', :development)

# Configure Sinatra
set :port, 4567
set :bind, '0.0.0.0'

# Home page - shows all books
get '/' do
  @books = Book.all.order_by(created_at: :desc)
  erb :index
end

# API endpoint - get all books as JSON
get '/api/books' do
  content_type :json
  books = Book.all.order_by(created_at: :desc)
  books.to_json
end

# API endpoint - get a single book
get '/api/books/:id' do
  content_type :json
  book = Book.find(params[:id])
  book.to_json
rescue Mongoid::Errors::DocumentNotFound
  status 404
  { error: 'Book not found' }.to_json
end

# API endpoint - create a new book
post '/api/books' do
  content_type :json
  data = JSON.parse(request.body.read)
  book = Book.create!(data)
  status 201
  book.to_json
rescue JSON::ParserError
  status 400
  { error: 'Invalid JSON' }.to_json
rescue Mongoid::Errors::Validations => e
  status 422
  { error: e.message }.to_json
end

# API endpoint - delete a book
delete '/api/books/:id' do
  content_type :json
  book = Book.find(params[:id])
  book.destroy
  { message: 'Book deleted successfully' }.to_json
rescue Mongoid::Errors::DocumentNotFound
  status 404
  { error: 'Book not found' }.to_json
end

__END__

@@index
<!DOCTYPE html>
<html>
<head>
  <title>Simple Sinatra MongoDB App</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      max-width: 800px;
      margin: 50px auto;
      padding: 20px;
      background-color: #f5f5f5;
    }
    h1 {
      color: #333;
    }
    .book {
      background: white;
      padding: 15px;
      margin: 10px 0;
      border-radius: 5px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .book h2 {
      margin: 0 0 10px 0;
      color: #2c3e50;
    }
    .book p {
      margin: 5px 0;
      color: #666;
    }
    .no-books {
      text-align: center;
      padding: 40px;
      background: white;
      border-radius: 5px;
    }
    .info {
      background: #e8f4f8;
      padding: 15px;
      border-radius: 5px;
      margin-bottom: 20px;
    }
    code {
      background: #f4f4f4;
      padding: 2px 6px;
      border-radius: 3px;
      font-family: monospace;
    }
  </style>
</head>
<body>
  <h1>📚 Simple Sinatra MongoDB App</h1>

  <div class="info">
    <p><strong>API Endpoints:</strong></p>
    <ul>
      <li>GET <code>/api/books</code> - Get all books</li>
      <li>GET <code>/api/books/:id</code> - Get a specific book</li>
      <li>POST <code>/api/books</code> - Create a new book</li>
      <li>DELETE <code>/api/books/:id</code> - Delete a book</li>
    </ul>
  </div>

  <h2>Books in Database (<%= @books.count %>)</h2>

  <% if @books.empty? %>
    <div class="no-books">
      <p>No books in the database yet!</p>
      <p>Run <code>ruby seed.rb</code> to add some sample books.</p>
    </div>
  <% else %>
    <% @books.each do |book| %>
      <div class="book">
        <h2><%= book.title %></h2>
        <p><strong>Author:</strong> <%= book.author %></p>
        <% if book.year %>
          <p><strong>Year:</strong> <%= book.year %></p>
        <% end %>
        <% if book.genre %>
          <p><strong>Genre:</strong> <%= book.genre %></p>
        <% end %>
        <p style="color: #999; font-size: 0.9em;">
          <strong>ID:</strong> <%= book.id %>
        </p>
      </div>
    <% end %>
  <% end %>
</body>
</html>
