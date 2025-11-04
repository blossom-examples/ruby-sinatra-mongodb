# Simple Sinatra MongoDB Blog

A simple blog application demonstrating how to use MongoDB with Sinatra using Mongoid ODM. Features a complete CRUD interface for managing blog posts.

## Features

- **Post Model** with MongoDB persistence (title, content, author)
- **Full CRUD Operations** using ERB templates:
  - List all posts
  - View individual posts
  - Create new posts
  - Edit existing posts
  - Delete posts
- Clean, responsive web interface
- Seed script to populate database with sample data

## Prerequisites

- Ruby
- MongoDB (running on localhost:27017)

## Installation

1. Install dependencies:
```bash
bundle install
```

2. Make sure MongoDB is running on your local machine

3. Seed the database with sample posts:
```bash
ruby seed.rb
```

## Running the Application

Start the Sinatra server:
```bash
ruby app.rb
```

Then visit: http://localhost:4567

## Application Routes

- `GET /` - List all posts
- `GET /posts/new` - Show form to create a new post
- `POST /posts` - Create a new post
- `GET /posts/:id` - View a single post
- `GET /posts/:id/edit` - Show form to edit a post
- `POST /posts/:id` - Update a post
- `POST /posts/:id/delete` - Delete a post

## Project Structure

```
.
├── app.rb                  # Main Sinatra application with routes
├── models/
│   └── post.rb            # Post model with Mongoid
├── views/
│   ├── layout.erb         # Main layout template
│   ├── index.erb          # List all posts
│   ├── show.erb           # Show single post
│   ├── new.erb            # Create new post form
│   └── edit.erb           # Edit post form
├── config/
│   └── mongoid.yml        # MongoDB configuration
├── seed.rb                # Database seeding script
├── Gemfile                # Ruby dependencies
└── README.md              # This file
```

## MongoDB Configuration

The app uses Mongoid to connect to MongoDB. Configuration is in [config/mongoid.yml](config/mongoid.yml):

- **Development**: Connects to `sinatra_books_dev` database on localhost:27017
- **Production**: Uses `MONGODB_URI` environment variable
- **Test**: Connects to `sinatra_books_test` database

## Post Model

The Post model ([models/post.rb](models/post.rb)) includes:
- `title` (String, required)
- `content` (String, required)
- `author` (String, required)
- Automatic timestamps (`created_at`, `updated_at`)

## How It Works

This example demonstrates:

1. **Mongoid ODM**: Object-Document Mapping for MongoDB in Ruby
2. **ERB Templates**: Embedded Ruby for generating HTML views
3. **CRUD Operations**: Complete Create, Read, Update, Delete functionality
4. **Form Handling**: Processing user input from HTML forms
5. **Validations**: Ensuring data integrity with model validations
6. **Routing**: Clean URL structure with RESTful conventions

This is a great starting point for learning how to build web applications with Sinatra and MongoDB!
