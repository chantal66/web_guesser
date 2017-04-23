require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)
@@remaining_guesses = 5
@@guessed_it = false

get '/' do
  cheat_mode = params[:cheat]
  message, css_color = check_guess(params[:guess].to_i) if params[:guess]
  if @@remaining_guesses == 1 && !@@guessed_it
    SECRET_NUMBER = rand(100)
    @@remaining_guesses = 5
    message = 'GAME OVER'
    css_color = 'red'
  elsif @@guessed_it
    SECRET_NUMBER = rand(100)
    @@guessed_it = false
    @@remaining_guesses = 5
  else
    @@remaining_guesses -=1
  end
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message,
  css_color: css_color, cheat_mode: cheat_mode, count: @@remaining_guesses}
end

def check_guess(guess)
  case
  when guess == SECRET_NUMBER
    @@guessed_it = true
    ["You are right, The secret number is #{SECRET_NUMBER}", 'green']
  when guess > SECRET_NUMBER + 5
    ["You are way to HIGH", 'red']
  when guess > SECRET_NUMBER
    ["TOO HIGH", '#e5d5d5']
  when guess < SECRET_NUMBER - 5
    ["You are way too LOW", 'red']
  when guess < SECRET_NUMBER
    ['TOO LOW', '#e5d5d5']
  end
end

