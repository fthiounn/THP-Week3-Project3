require 'bundler'
Bundler.require

require 'open-uri'
require 'json'
require 'csv'

require_relative 'lib/app/scrapper'


Scrapper.new.perform