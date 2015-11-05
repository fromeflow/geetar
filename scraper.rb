require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

BASE_URL = 'https://www.ultimate-guitar.com/search.php'

module Scraper

  def get_page(page_url)
    Nokogiri::HTML( open(page_url, 'User-Agent' => 'firefox') )
  end

end

class Search
  include Scraper

  def initialize(query)
    page_url = "#{BASE_URL}?search_type=title&value=#{query})"
    @output = self.get_page(page_url)
  end

  def results
    rows = @output.css('.tresults').css('tr')
    # Drop the header row
    rows = rows.drop(1)
    result_rows = rows.map do |row|
      Result.new(row)
    end
    return result_rows
  end

end

class Result

  def initialize(row)
    @row = row
  end

  def title
    title = @row.css('td')[1].css('a').first
    { text: title.text, href: title[:href] }
  end

  def item_type
    # Chords or tab
    @row.css('td')[3].text
  end

  def artist
    @row.css('td')[0].text
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
