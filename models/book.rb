require 'mongoid'

class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :author, type: String
  field :year, type: Integer
  field :genre, type: String

  validates :title, presence: true
  validates :author, presence: true
end
