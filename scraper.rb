require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

BASE_URL = 'https://www.ultimate-guitar.com/search.php'

class Scraper

  def initialize(query)
    @page = Nokogiri::HTML( open("#{BASE_URL}?search_type=title&value=#{query})", 'User-Agent' => 'firefox') )
  end

  def results
    @page.css('.tresults')
  end

end
