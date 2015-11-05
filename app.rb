require 'rubygems'
require 'sinatra'
require 'haml'
require 'pry'
require_relative 'scraper.rb'

get '/' do
  haml :scraper
end

post '/results' do
  haml :results
end
