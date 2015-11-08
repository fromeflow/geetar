require 'rubygems'
require 'haml'
require 'pry'
require 'sass/plugin/rack'
require './app'
require './scraper.rb'

Sass::Plugin.options[:style] = :compressed
Sass::Plugin.options[:template_location] = './assets/css'
Sass::Plugin.options[:css_location] = './public/css'
use Sass::Plugin::Rack

run Sinatra::Application
