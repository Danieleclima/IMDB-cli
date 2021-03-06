require_relative "../lib/scraper.rb"
require_relative "../lib/movie.rb"
require 'pry'
require 'nokogiri'

class CommandLineInterface
  
  POPULAR_MOVIES = "https://www.imdb.com/chart/moviemeter"
  
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
    puts "To view the summary of a particular movie, type its index number"
    puts "To list all of the movies currently showing at the cinema, enter 'what's on'."
    puts "To list all the movie genres alphabetically, enter 'list genres'."
    puts "To list all of the movies for a particular genre, type the name of the genre."
    puts "To view a list of the top upcoming movies, type 'coming soon'"
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    answer = gets.chomp
    while answer != "exit"
     counter = 0
      if answer == 'list movies'
        list_movies
      elsif answer == "what's on"
        whats_on
      elsif answer == "list genres"
        list_genres
      elsif answer == "coming soon"
        coming_soon
      elsif answer.to_i != 0
        show_summary (answer.to_i)
      elsif all_genres.include?(answer.capitalize)
        puts "Here's a list with all the #{answer.capitalize} movies:"
        search_by_genre (answer)
      else
        puts "That's not a valid answer"
      end
      if counter > 0
        puts "What would you like to do now?"
        answer = gets.chomp
      else
        puts "What would you like to do?"
        answer = gets.chomp
      end
        counter += 1
    end
    "Thanks for using this movie guide!!"
  end
  
  def list_movies
    Movie.all.each_with_index do |movie, index|
      if movie.rating == ""
       puts "#{index + 1}. #{movie.title} -- No rating yet -- #{movie.year}" 
      else
       puts "#{index + 1}. #{movie.title} -- #{movie.rating} -- #{movie.year}"
      end
    end
  end
  
  def whats_on
    puts "Here's a list with all the movies that are currently available on cinemas:"
    list = Movie.all.select do |movie|
      movie.in_cinemas == "Showing" 
    end
    list.each_with_index do |film, index|
      if film.rating == ""
        puts "#{index + 1}. #{film.title} -- No rating available"
      else
        puts "#{index + 1}. #{film.title} -- #{film.rating}"
      end
   end
  end
  
  def show_summary (number)
    puts "You have selected #{Movie.all[number - 1].title}"
    puts Movie.all[number - 1].summary
  end
  
  def coming_soon
    puts "The following movies are about to be released, stay tuned!"
    list = Movie.all.select do |movie|
      movie.in_cinemas == "Coming Soon" 
    end
    list.each_with_index do |film, index|
      if film.rating == ""
        puts "#{index + 1}. #{film.title} -- No rating available"
      else
        puts "#{index + 1}. #{film.title} -- #{film.rating}"
      end
    end
  end
  
  def all_genres
  genres = []
  Movie.all.each do |movie|
     genres.concat(movie.genre)
  end
  genres.uniq
  end
  
  def list_genres
   puts "Here's a list with all the genres, enjoy!"  
    list = all_genres
    list.sort.each_with_index do |type, index|
      puts "#{index + 1} #{type}"
    end
  end

  def search_by_genre (input)
    input.capitalize!
    list = Movie.all.select do |movie|
      movie.genre.include?(input) 
    end
    list.each_with_index do |film, index|
      if film.rating == ""
        puts "#{index + 1}. #{film.title} -- No rating available"
      else
        puts "#{index + 1}. #{film.title} -- #{film.rating}"
      end
   end
  end
  
end