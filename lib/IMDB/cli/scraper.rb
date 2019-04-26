require 'pry'
require 'open-uri'
require 'nokogiri' 

  def scrape_popular_movies (index_url)
    doc = Nokogiri::HTML(open(index_url))
    movies = []
    binding.pry
    doc.css("tbody.lister-list").each do |movie|
      new_movie = {}
      movie_title = doc.css("td.titleColumn a").text
      movie_year = doc.css("span.secondaryInfo").text
      
      new_movie[:title] = movie_title
      new_movie[:year] = movie_year 
      movies << new_movie
    end
    movies
  end
  
  scrape_popular_movies("https://www.imdb.com/chart/moviemeter?ref_=nv_mv_mpm")
