require_relative "../lib/scraper.rb"
require_relative "../lib/movie.rb"
require 'nokogiri'

class CommandLineInterface
  POPULAR_MOVIES = "https://www.imdb.com/chart/moviemeter?ref_=nv_mv_mpm/"

  def run
    create_movies
    add_attributes_to_movies
    display_students
  end

  def create_movies
    movie_array = MovieScraper.scrape_popular_movies(POPULAR_MOVIES)
    Student.create_from_collection(students_array)
  end

  def add_attributes_to_students
    Student.all.each do |student|
      attributes = Scraper.scrape_profile_page(BASE_PATH + student.profile_url)
      student.add_student_attributes(attributes)
    end
  end
end