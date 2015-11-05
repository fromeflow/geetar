require 'rubygems'
require 'sinatra'
require 'haml'
require 'pry'
require_relative 'scraper.rb'

get '/' do
  haml :scraper
end

post '/results' do
  scraper = Scraper.new(params[:query])
  haml :results, locals: {search_results: scraper.results}
end
