# Ruby Sinatra MongoDB Tutorial Deploy on Blossom

[![Blossom Badge](https://img.boltops.com/images/blossom/logos/blossom-readme.png)](https://blossom-cloud.com)

A ready-to-deploy Ruby Sinatra app with MongoDB to get you started quickly on [Blossom](https://blossom-cloud.com).

This example demonstrates:
- Complete CRUD operations with MongoDB using Mongoid ODM
- ERB templates for server-side rendering
- Automatic database seeding
- Clean RESTful routing

## Quick Start

```bash
# Install dependencies
bundle install

# Make sure MongoDB is running
# See MongoDB Setup section below

# Run the app
bin/web
```

Visit `http://localhost:4567` in your browser to see the blog application.

The app will automatically seed the database with sample posts if it's empty.

## MongoDB Setup

### Local Development

Using Docker Compose (recommended):

```yaml
# docker-compose.yml
services:
  db:
    image: mongo:8
    ports:
      - 27017:27017
    environment:
      MONGO_INITDB_ROOT_USERNAME: admin
      MONGO_INITDB_ROOT_PASSWORD: root_password
      MONGO_INITDB_DATABASE: demo
    volumes:
      - mongodb_data:/data/db

volumes:
  mongodb_data:
```

```bash
docker-compose up -d
```

Or install MongoDB locally and ensure it's running on `localhost:27017`.

### Configuration

The app uses environment variables for MongoDB connection:

- `DATABASE_URL` or `MONGODB_URI` - Full MongoDB connection URI
- `RACK_ENV` - Set to `production` for production config (defaults to `development`)

**Connection String Format:**
```
mongodb://username:password@host:port/database
```

**Note:** The `auth_source: admin` is automatically configured in [config/mongoid.yml](config/mongoid.yml) for root user authentication.

### Example with Custom MongoDB

```bash
DATABASE_URL=mongodb://admin:password@localhost:27017/mydb bin/web
```

## Features

- **Post Model** with MongoDB persistence (title, content, author)
- **Full CRUD Operations**:
  - List all posts
  - View individual posts
  - Create new posts with forms
  - Edit existing posts
  - Delete posts
- **Automatic seeding** - Database populated with sample data on first run
- **Clean web interface** - Responsive design with ERB templates

## Routes

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
├── app.rb                  # Main Sinatra application
├── config.ru               # Rack configuration
├── models/
│   └── post.rb            # Post model with Mongoid
├── views/
│   ├── layout.erb         # Main layout
│   ├── index.erb          # List posts
│   ├── show.erb           # Show post
│   ├── new.erb            # Create post form
│   └── edit.erb           # Edit post form
├── config/
│   └── mongoid.yml        # MongoDB configuration
├── db/
│   └── seeds.rb           # Database seeding
└── bin/
    └── web                # Start script
```

## Manual Seeding

To reset the database with fresh sample data:

```bash
ruby db/seeds.rb
```

## Deploying to Blossom

1. Ensure you have a MongoDB service provisioned
2. Set the `DATABASE_URL` environment variable to your MongoDB connection string:
   ```
   mongodb://username:password@host:port/database
   ```
3. Deploy with `blossom deploy`

The app will automatically:
- Detect the production environment via `RACK_ENV=production`
- Connect to MongoDB using `DATABASE_URL`
- Seed the database if empty

## Learn More

- [Blossom Documentation](https://docs.blossom-cloud.com)
- [Sinatra Documentation](http://sinatrarb.com/documentation.html)
- [Mongoid Documentation](https://www.mongodb.com/docs/mongoid/current/)
