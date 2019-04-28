require_relative "../lib/scraper.rb"
require_relative "../lib/movie.rb"
require 'pry'
require 'nokogiri'

class CommandLineInterface
  
  POPULAR_MOVIES = "https://www.imdb.com/chart/moviemeter?ref_=nv_mv_mpm/"
  
  def run
    create_movies
    add_attributes_to_movies
    controller
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
  
  def controller
    puts "Welcome to your movie guide!"
    puts "To list the most popular movies sorted by popularity , enter 'list movies'."
    puts "To list all of the movies currently showing at the cinema, enter 'what's on'."
    puts "To list all the movie genres, enter 'list genres'."
    puts "To list all of the movies for a particular genre, type the genre."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    answer = gets.chomp
    list_movies if answer == 'list movies'
  end
  
  def list_movies
    Movie.all.each_with_index do |movie, index|
      puts "#{index + 1}. #{movie.title} - #{movie.rating}"
    end
  end
  
end

