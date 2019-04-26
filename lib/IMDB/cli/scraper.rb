require 'pry'
require 'open-uri'
require 'nokogiri' 

class MovieScraper 

@@all = []
@@movies = {}

  def scrape_popular_movies (index_url)
    doc = Nokogiri::HTML(open(index_url))
    movies = []
    binding.pry
    doc.css("tbody.lister-list td.titleColumn a").each do |movie|
      new_movie = {}
      movie_title = movie.css("td.titleColumn a").text
      movie_year = movie.css("span.secondaryInfo").text
      
      new_movie[:title] = movie_title
      new_movie[:year] = movie_year 
      movies << new_movie
    end
    movies
  end
  
end

  scrape_popular_movies("https://www.imdb.com/chart/moviemeter?ref_=nv_mv_mpm")
