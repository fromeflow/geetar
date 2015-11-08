require 'sinatra'

require_relative 'scraper.rb'

get '/' do
  haml :index
end

post '/results' do
  search = Search.new(params[:query])
  haml :results, locals: {search_results: search.results}
end

get '/show' do
  tab = Tab.new( params[:url] )
  haml :show, locals: {tab: tab}, layout: false
end
