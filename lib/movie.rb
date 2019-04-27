require 'pry'

class Movie
  
  attr_accessor :title, :year, :url, :rating, :in_cinemas, :genre
  
  @@all = []
  
  def initialize (movies_hash)
    binding.pry
    movies_hash.each do |key, value|
    self.send(("#{key}="), value)
    end
    @@all << self
  end
  
  def self.create_from_collection(movies_array)
    movies_array.each do |movie|
        Movie.new(movie)
    end
  end
  
  def add_movie_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send(("#{key}="), value)
    end
    self
  end
  
  def self.all
    @@all
  end
  
end