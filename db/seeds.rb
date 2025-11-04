# Sample posts data
SAMPLE_POSTS = [
  {
    title: "Getting Started with Ruby and MongoDB",
    author: "Jane Developer",
    content: "MongoDB is a great choice for Ruby applications. With the Mongoid ODM, you can easily map Ruby objects to MongoDB documents. This post will walk you through the basics of setting up a Ruby application with MongoDB.\n\nFirst, you'll need to install the mongoid gem. Then configure your database connection in mongoid.yml. After that, you can start defining your models and working with data!"
  },
  {
    title: "Why Sinatra is Perfect for Small Projects",
    author: "John Smith",
    content: "Sinatra is a lightweight web framework for Ruby that's perfect for small to medium-sized projects. Unlike Rails, Sinatra doesn't impose a lot of structure on your application. You have the freedom to organize your code however you want.\n\nThis makes it ideal for APIs, microservices, and simple web applications where you don't need all the bells and whistles of a full framework."
  },
  {
    title: "Understanding MongoDB Documents",
    author: "Sarah Chen",
    content: "MongoDB stores data in flexible, JSON-like documents. This means fields can vary from document to document and data structure can be changed over time.\n\nDocuments are organized into collections, which are analogous to tables in relational databases. However, unlike tables, collections do not enforce a schema, giving you more flexibility in how you structure your data."
  },
  {
    title: "Building RESTful APIs with Sinatra",
    author: "Mike Johnson",
    content: "Sinatra makes it incredibly easy to build RESTful APIs. With just a few lines of code, you can define routes that respond to HTTP verbs like GET, POST, PUT, and DELETE.\n\nThe simplicity of Sinatra means there's less magic happening behind the scenes. What you see is what you get, making it easier to understand and debug your application."
  },
  {
    title: "Tips for Working with Mongoid",
    author: "Emily Rodriguez",
    content: "Mongoid is an Object-Document-Mapper (ODM) for MongoDB written in Ruby. Here are some tips for working with it effectively:\n\n1. Always define validations on your models\n2. Use embedded documents for one-to-many relationships when appropriate\n3. Take advantage of Mongoid's query methods\n4. Remember to index your frequently queried fields\n5. Use the Rails console to test your queries"
  }
].freeze

# Method to create sample posts
def seed_posts
  SAMPLE_POSTS.each do |post_data|
    Post.create!(post_data)
  end
end

# If running this file directly (ruby db/seed.rb)
if __FILE__ == $PROGRAM_NAME
  require "mongoid"
  require_relative "../models/post"

  Mongoid.load!("config/mongoid.yml", :development)

  puts "Seeding database..."
  Post.delete_all
  puts "Cleared existing posts"

  seed_posts
  puts "Created #{Post.count} posts."
end
