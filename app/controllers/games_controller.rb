class GamesController < ApplicationController
  require "open-uri"
  require "json"

  def new
    @random = []
    @range = ('a'..'z').to_a
    10.times {
      @random << @range.sample
    }
    @random
  end

  def score
    @word = params[:word]
    @splitted_word = @word.split('')
    @letters_grid = params[:letters].split(' ')
    @splitted_word.each do |letter|
      if @letters_grid.include?(letter) == false
        #  binding.pry
        @answer = "sorry but #{@word.upcase} can't be built out of #{@letters_grid.join(", ").upcase} "
      elsif english_word(@word) == false
        @answer = 'ENGLISH MOTHERFUCKER DO YOU SPEAK IT?'
      else
        @answer = "Congratulations, #{@word.upcase} is a valid English Word"
      end
    end
  end

  def english_word(word)
    @url = "https://wagon-dictionary.herokuapp.com/#{word}"
    @parsed_url = JSON.parse(open(@url).read)
    @parsed_url['found']
    # binding.pry
  end


end
