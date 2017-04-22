require 'sinatra'
require 'sinatra/reloader'

get '/' do
  erb :index, :locals => {:number => number = rand(0..100)}
end