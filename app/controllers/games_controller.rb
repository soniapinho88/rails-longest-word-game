require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @word = params[:play]
    @letters = params[:letters].split
    api_parse
    @output = valid_word
  end

  private

  def api_parse
    @res = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}")
    @res = JSON.parse(@res.read)
  end

  def valid_word
    if letters_valid && @res["found"]
      'CONGRATULATIONS! Your word is valid'
    else
      'NOT A VALID WORD!'
    end
  end

  def letters_valid
    @word_in_grid = @word.chars.all? do |char|
      @word.count(char) <= @letters.count(char)
    end
  end
end
