require 'sinatra'
require 'json'

get '/' do
  "Hello, world"
end

get '/todos' do
  content_type :json
  { :title => 'some_title', :description => 'some description' }.to_json
end

post '/todo' do

end

