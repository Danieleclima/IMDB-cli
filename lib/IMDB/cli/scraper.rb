require 'pry'
require 'open-uri'
require 'nokogiri' 

class MovieScraper 

@@all = []
@@movies = {}

  def scrape_popular_movies (index_url)
    doc = Nokogiri::HTML(open(index_url))
    movies = []
    doc.css("tbody.lister-list td.titleColumn").each do |movie|
      new_movie = {}
      movie_title = movie.css("a").children.text
      movie_year = movie.css("span").children.text
      binding.pry
      @@movies[:title] = movie_title
      @@movies[:year] = movie_year 
      @@all << @@movies
    end
    movies
  end
  
end

 imdb = MovieScraper.new 
 imdb.scrape_popular_movies("https://www.imdb.com/chart/moviemeter?ref_=nv_mv_mpm")
