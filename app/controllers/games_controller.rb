require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
  grid = []
  10.times { grid << ('A'..'Z').to_a.sample }
  @letters = grid
end

  def score
    @params = params
    @input
    @letters
    @result = run_game(@input, @letters)
  end

  def run_game(attempt, grid)
    if a true_word?(attempt) && word_in_grid?(attempt, grid)
      'Well done!'
    elsif !a true_word?(attempt)
      "Sorry but #{attempt} is not an English word"
    elsif !word_in_grid(attempt, grid)
      "Sorry but #{attempt} not on the grid"
    end
  end

  def a_true_word?(word)
    url= "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    user ['found']? true : false
  end

def word_in_grid?(attempt, grid)
  attempt.downcase!
  attempt.chars.all? do |letter|
    attempt.count(letter) <= grid.count(letter)
  end
end
end
