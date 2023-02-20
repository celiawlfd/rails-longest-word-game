require "json"
require "open-uri" # GEM to parse data from web

class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = []
    10.times do
      @letters << alphabet.sample
    end
    @letters
  end

  def score
    @word = params[:word]
    wordletter = @word.split('')
    @letters = params[:letters].split(' ')
      if (wordletter - @letters).empty?
        @results = parse(@word) ? ['Congratulations!', 'is a valid English word!'] : ['Sorry but', 'does not seem to be a valid English word...']

      else
        @results = ['Sorry but', "can't be built out of", params[:letters]]
      end
  end

  private
  def parse(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = URI.open(url).read
    wordapi = JSON.parse(user_serialized)
    wordapi['found']
  end
end
