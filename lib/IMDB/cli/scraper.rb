require 'pry'
require 'open-uri'
require 'nokogiri' 

class MovieScraper 

@@all = []

  def scrape_popular_movies (index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css("tbody.lister-list td.titleColumn").each do |movie|
      new_movie = {}
      movie_title = movie.css("a").children.text
      movie_year = movie.css("span.secondaryInfo").children.text[1..4]
      new_movie[:title]= movie_title
      new_movie[:year] = movie_year
      @@all << new_movie
    end
    @@all
    binding.pry
  end
  
end

 imdb = MovieScraper.new 
 imdb.scrape_popular_movies("https://www.imdb.com/chart/moviemeter?ref_=nv_mv_mpm")
