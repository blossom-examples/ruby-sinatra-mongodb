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
- **Automatic seeding** - Database is automatically populated with sample data on first run

## Prerequisites

- Ruby
- MongoDB (running on localhost:27017)

## Quick Start

1. Install dependencies:
```bash
bundle install
```

2. Make sure MongoDB is running on your local machine

3. Start the application:

**Option 1: Using Puma (recommended)**
```bash
bin/web
```

**Option 2: Using WEBrick**
```bash
ruby app.rb
```

The app will automatically seed the database with sample posts if it's empty. Then visit: http://localhost:4567

## Manual Seeding (Optional)

If you want to reset the database with fresh sample data:
```bash
ruby db/seeds.rb
```

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
├── config.ru               # Rack configuration for Puma/other servers
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
├── db/
│   └── seeds.rb           # Database seeding script
├── bin/
│   └── web                # Script to start app with Puma
├── Gemfile                # Ruby dependencies
└── README.md              # This file
```

## MongoDB Configuration

The app uses Mongoid to connect to MongoDB. Configuration is in [config/mongoid.yml](config/mongoid.yml):

### Development
Connects to `demo` database on localhost:27017 with authentication:
- Username: `admin` (or set `MONGODB_USERNAME` env var)
- Password: `root_password` (or set `MONGODB_PASSWORD` env var)
- Auth source: `admin`

### Production
To use production configuration, set `RACK_ENV=production`.

Uses a MongoDB connection URI from environment variables:
- `MONGODB_URI` (preferred) or `DATABASE_URL`
- Format: `mongodb://username:password@host:port/database?authSource=admin`

**Example:**
```bash
RACK_ENV=production MONGODB_URI=mongodb://user:pass@host:27017/mydb bin/web
```

Common platforms that provide `MONGODB_URI`:
- **Heroku**: MongoDB Atlas add-on
- **Railway**: MongoDB service
- **Render**: MongoDB service
- **Fly.io**: Set manually
- **MongoDB Atlas**: Available in connection settings

### Test
Connects to `demo_test` database on localhost:27017

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
