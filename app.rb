require 'rubygems'
require 'sinatra'
require 'haml'
require 'pry'
require_relative 'scraper.rb'

get '/' do
  page = Scraper.new
  page.page_title
end