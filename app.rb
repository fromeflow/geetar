require 'rubygems'
require 'sinatra'
require 'haml'
require 'pry'
require_relative 'scraper.rb'

get '/' do
  haml :scraper
end

post '/results' do
  search = Search.new(params[:query])
  haml :results, locals: {search_results: search.results}
end
