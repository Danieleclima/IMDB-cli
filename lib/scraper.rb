require 'pry'
require 'open-uri'
require 'nokogiri' 

class MovieScraper 

@@all = []
  
  def self.scrape_popular_movies (index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css("tbody.lister-list td.titleColumn").each do |movie|
      new_movie = {}
      movie_title = movie.css("a").children.text
      movie_year = movie.css("span.secondaryInfo").children.text[1..4]
      movie_url = movie.css("a").attribute("href").value
      new_movie[:title]= movie_title
      new_movie[:year] = movie_year
      new_movie[:url] = "https://www.imdb.com" + movie.css("a").attribute("href").text
      @@all << new_movie
    end
    @@all
  end
  
  def self.scrape_movie_page (movie_page)
    doc = Nokogiri::HTML(open(movie_page))
    movie_rating = doc.css("div.ratingValue span").children.text
    in_cinemas = true if doc.css("div.winner-option")
    size = doc.css("div.subtext a").children.length - 2 if doc.css("div.subtext a").children.length > 1 
    size = 0 if doc.css("div.subtext a").children.length <= 1
    genre = doc.css("div.subtext a").children[0..size].text.split /(?=[A-Z])/
    @@all.collect do |movie|
      if movie[:url] == movie_page
        movie[:rating] = movie_rating 
        movie[:in_cinemas] = in_cinemas
        movie[:genre] = genre
    binding.pry
      end
    end
  end
  
end

 MovieScraper.scrape_popular_movies("https://www.imdb.com/chart/moviemeter?ref_=nv_mv_mpm")
 MovieScraper.scrape_movie_page("https://www.imdb.com/title/tt4154796/")
