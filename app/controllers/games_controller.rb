require 'open-uri'

class GamesController < ApplicationController

  def new 
    #TODO
    @letters_string = ('a'..'z').to_a.shuffle.sample(10).join("") 
  end

  def score
     
    @score = 0
    @letters_string = params[:letters_string]
    @word = params[:word]    
    @start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC) - params[:start_time].to_f 
    @guess = nil
    #is it built 
    if ((@word.chars-@letters_string.chars).empty?)
      @guess = true
    else
      @guess = false
    end

    json_parse = URI.open("https://dictionary.lewagon.com/#{@word}").read
    response = JSON.parse(json_parse )
    @found = response["found"]

    if (!@found)
      @score = 0
      @message = "Sorry but #{@word} couldn't be build out #{@letters_string.to_a.join(",")}"
    elsif (!@guess) 
      @score = 0
      @message = "Sorry but #{@word} doesn't seem to be a valid English word..."
    else
      @score = 0
      @message = "Congratulations! #{@word} is a valid English word!"
    end

    #debugger
  end
end
