
require 'open-uri'
require 'nokogiri' 

  def scrape_index_page (index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css("tbody.lister-list").each_with_index do |movie, index|
      binding.pry
    
    end
  end