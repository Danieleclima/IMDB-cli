require_relative "../lib/scraper.rb"
require_relative "../lib/movie.rb"
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
      attributes = Movie.scrape_movie_page(movie.url)
      movie.add_movie_attributes(attributes)
      binding.pry
    end
  end
  
end


CommandLineInterface.add_attributes_to_movies
