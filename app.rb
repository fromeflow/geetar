require 'sinatra'

require_relative 'scraper.rb'

get '/' do
  haml :index
end

get '/results' do
  search = Search.new(params[:query], params[:page])
  haml :results, locals: {search_results: search.results, page_links: search.page_links}
end

get '/show' do
  tab = Tab.new( params[:url] )
  haml :show, locals: {tab: tab}, layout: false
end
