require 'sinatra'

get '/' do
  "The secret number is #{rand(0..100)}"
end