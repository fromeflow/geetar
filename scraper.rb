require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'cgi'

BASE_URL = 'https://www.ultimate-guitar.com/search.php'

module Scraper

  def get_page(page_url)
    Nokogiri::HTML( open(page_url, 'User-Agent' => 'firefox') )
  end

end

class Search
  include Scraper

  def initialize(query)
    query_string = CGI::escape(query)
    page_url = "#{BASE_URL}?search_type=title&value=#{query_string})"
    @output = self.get_page(page_url)
  end

  def results
    rows = @output.css('.tresults').css('tr')
    # Drop the header row
    rows = rows.drop(1)
    rows.map! do |row|
      Result.new(row)
    end

    # Add artists to each result
    artist = ''
    rows.each do |row|
      if row.artist != "\u00A0"
        artist = row.artist
      else
        row.artist = artist
      end
    end

    # Remove non-text (fake) tabs
    rows.reject! do |row|
      row.item_type.match /(pro|power|video)/i
    end

    return rows
  end
end

class Result
  attr_accessor :artist, :item_type

  def initialize(row)
    @row = row
    @artist = @row.css('td')[0].text.strip
    # Chords or tab
    @item_type = @row.css('td')[3].text.strip
  end

  def title
    title = @row.css('td')[1].css('a').first
    { text: title.text, href: title[:href] }
  end

end

class Tab
  include Scraper

  def initialize(tab_url)
    @output = self.get_page(tab_url)
  end

  def content
    @output.css('#cont').css('pre')[2].to_s
  end

end
