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
      movie_url = movie.css("a").attribute("href").value
      binding.pry
      new_movie[:title]= movie_title
      new_movie[:year] = movie_year
      new_movie[:url] = "https://www.imdb.com" + movie.css("a").attribute("href").text
      @@all << new_movie
    end
    @@all
  end
  
  
end

 imdb = MovieScraper.new 
 imdb.scrape_popular_movies("https://www.imdb.com/chart/moviemeter?ref_=nv_mv_mpm")
