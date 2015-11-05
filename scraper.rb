require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

BASE_URL = 'https://www.ultimate-guitar.com/search.php'

class Scraper

  def initialize(query)
    page_url = "#{BASE_URL}?search_type=title&value=#{query})"
    @page = Nokogiri::HTML( open(page_url, 'User-Agent' => 'firefox') )
  end

  def results
    rows = @page.css('.tresults').css('tr')
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
