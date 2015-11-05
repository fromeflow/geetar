require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  
  def initialize
    @page = Nokogiri::HTML(open("http://jpalmieri.com/"))
  end

  def page_title
    @page.css('p')
  end
end