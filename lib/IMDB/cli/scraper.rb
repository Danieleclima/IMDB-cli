require 'pry'
require 'open-uri'
require 'nokogiri' 

  def scrape_index_page (index_url)
    doc = Nokogiri::HTML(open(index_url))
    movies = []
    doc.css("tbody.lister-list").each do |movie|
      
    
    end
  end
