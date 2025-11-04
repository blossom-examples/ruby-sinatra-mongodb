require "sinatra"
require "mongoid"
require_relative "models/post"

# Load Mongoid configuration
Mongoid.load!("config/mongoid.yml", :development)

# Configure Sinatra
set :port, 4567
set :bind, "0.0.0.0"

# List all posts
get "/" do
  @posts = Post.all.order_by(created_at: :desc)
  erb :index
end

# Show form to create a new post
get "/posts/new" do
  @post = Post.new
  erb :new
end

# Create a new post
post "/posts" do
  @post = Post.new(
    title: params[:title],
    content: params[:content],
    author: params[:author]
  )

  if @post.save
    redirect "/"
  else
    erb :new
  end
end

# Show a single post
get "/posts/:id" do
  @post = Post.find(params[:id])
  erb :show
rescue Mongoid::Errors::DocumentNotFound
  status 404
  "Post not found"
end

# Show form to edit a post
get "/posts/:id/edit" do
  @post = Post.find(params[:id])
  erb :edit
rescue Mongoid::Errors::DocumentNotFound
  status 404
  "Post not found"
end

# Update a post
post "/posts/:id" do
  @post = Post.find(params[:id])

  @post.title = params[:title]
  @post.content = params[:content]
  @post.author = params[:author]

  if @post.save
    redirect "/posts/#{@post.id}"
  else
    erb :edit
  end
rescue Mongoid::Errors::DocumentNotFound
  status 404
  "Post not found"
end

# Delete a post
post "/posts/:id/delete" do
  @post = Post.find(params[:id])
  @post.destroy
  redirect "/"
rescue Mongoid::Errors::DocumentNotFound
  status 404
  "Post not found"
end
