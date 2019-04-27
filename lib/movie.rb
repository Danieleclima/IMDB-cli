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
  
  
end