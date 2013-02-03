require 'sinatra'
require 'coffee-script'

get '/application.js' do
  coffee :application
end

get '/' do
  "Hello, world"
end

