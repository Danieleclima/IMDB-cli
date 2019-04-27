require 'pry'

class Movie
  
  attr_accessor :title, :year, :url, :rating, :in_cinemas, :genre
  
  def initialize (movies_hash)
    binding.pry
  movies_hash.each do |key, value|
   self.send(("#{key}="), value)
  end
  
end