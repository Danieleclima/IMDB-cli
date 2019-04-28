require_relative "../lib/scraper.rb"
require_relative "../lib/movie.rb"
require 'pry'
require 'nokogiri'

class CommandLineInterface
  
  POPULAR_MOVIES = "https://www.imdb.com/chart/moviemeter?ref_=nv_mv_mpm/"
  
  def run
    create_movies
    add_attributes_to_movies
  end
  
  def create_movies
    movie_array = MovieScraper.scrape_popular_movies(POPULAR_MOVIES)
    Movie.create_from_collection(movie_array)
  end

  def add_attributes_to_movies
    Movie.all.each do |movie|
      attributes = MovieScraper.scrape_movie_page(movie.url)
      movie.add_movie_attributes(attributes)
    end
  end
  
  def contoller
    puts "Welcome to your movie guide!"
    puts "To list all the movies sorted by popularity , enter 'list movies'."
    puts "To list all of the movies currently showing at the cinema, enter 'what's on'."
    puts "To list all the movie genres, enter 'list genres'."
    puts "To list all of the movies for a particular genre, enter ''."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
  end
  
  
end

