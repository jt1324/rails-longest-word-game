require "open-uri"

class GamesController < ApplicationController

  def new

    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    # raise

  end

  def score
    @letters = params[:letters].split
    @word = params[:word]
    @valid_word = valid_word?(@word)
    @included = included?(@word, @letters)

  end

  private

  def included?(word, letters)
    word.upcase.chars.all? { |letter| word.upcase.count(letter) <= letters.count(letter) }
  end

  def valid_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  # def message
  #   if valid_word? && included?
  #     "Congratulations! #{@word} is a valid English word!"
  #   elsif !included?
  #     "Sorry but #{@word} can't be built out of #{@letters.join(', ')}"
  #   else
  #     "Sorry but #{@word} does not seem to be a valid English word..."
  #   end
  # end

end
