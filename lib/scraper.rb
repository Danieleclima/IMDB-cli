require 'pry'
require 'open-uri'
require 'nokogiri' 

class MovieScraper 
  
  def self.scrape_popular_movies (index_url)
    doc = Nokogiri::HTML(open(index_url))
    array = []
    doc.css("tbody.lister-list td.titleColumn").each do |movie|
      new_movie = {}
      movie_title = movie.css("a").children.text
      movie_year = movie.css("span.secondaryInfo").children.text[1..4]
      movie_url = movie.css("a").attribute("href").value
      new_movie[:title] = movie_title
      new_movie[:year] = movie_year
      new_movie[:url] = "https://www.imdb.com" + movie.css("a").attribute("href").text
      array << new_movie
    end
    array
  end
  
  def self.scrape_movie_page (movie_page)
    doc = Nokogiri::HTML(open(movie_page))
    movie_attributes = {}
    movie_rating = doc.css("div.ratingValue span").children.text
    if doc.css("div.info.table-cell a").children.text.include?"Get Showtimes"
      in_cinemas = "Showing"
    elsif doc.css("div.info.table-cell").children.text.include?"Release Date"
      in_cinemas = "Coming Soon"
    elsif doc.css("div.subtext a").pop.children.text.split(" ")[2].to_i < Time.now.year
      in_cinemas = "Not Showing"
    else
      in_cinemas = "Not Showing"
    end
    summary = doc.css("div.summary_text").children.text.gsub("\n", ' ').squeeze(' ')
    size = doc.css("div.subtext a").children.length - 2 if doc.css("div.subtext a").children.length > 1 
    size = 0 if doc.css("div.subtext a").children.length <= 1
    genre = doc.css("div.subtext a").children[0..size].text.gsub(/Sci-Fi/,'Fantasy').split /(?=[A-Z])/
    movie_attributes[:rating] = movie_rating 
    movie_attributes[:in_cinemas] = in_cinemas
    movie_attributes[:genre] = genre
    movie_attributes[:summary] = summary
    movie_attributes
  end
  
  def self.all
    @@all
  end
  
end

 #MovieScraper.scrape_popular_movies("https://www.imdb.com/chart/moviemeter?ref_=nv_mv_mpm")
 #MovieScraper.scrape_movie_page("https://www.imdb.com/title/tt6105098")
 #MovieScraper.extract_movie_urlscli
 #MovieScraper.add_attributes
 #MovieScraper.all
 