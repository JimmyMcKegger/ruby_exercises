#!/usr/bin/env ruby
require 'json'

class GuessingGame
  @@dificulties = ["easy", "medium", "hard"]
  @@games_ever_played = 0

  def initialize
    @@games_ever_played += 1
    puts "There have been #{@@games_ever_played} games played"

    @dificulty = nil

    # pick a lyric from the JSON file
    f = File.open("data.json", "r")
    data = f.read
    j = JSON.parse(data)
    @lyrics = j["data"].sample
    puts @lyrics
  end

  def play
    pick_difficulty
    puts "\nYou have selected #{@difficulty} mode.\n"
    self.send("#{@difficulty}_mode")
  end

  def pick_difficulty
    until @@dificulties.include?(@difficulty)
      puts "Welcome to the Lyric Guessing Game! Choose difficulty:\n\n1. Easy (Choices are provided)\n2. Medium (Guess the word)\n3. Hard (Guess the line)\n4. Random\n\nWhat is your choice (1-4)?\n"
      @difficulty = gets.chomp
      game_over if @difficulty == "exit"

      @difficulty = @difficulty.to_i
      if @difficulty == 4
        @difficulty = @@dificulties.sample
      elsif @difficulty.between?(1, 3)
        @difficulty = @@dificulties[@difficulty - 1]
      else
        puts "Invalid choice. Try again."
        @difficulty = nil
      end
    end
  end

  def easy_mode
    guess = 0
    until guess.between?(1, 3)
      puts "#{@lyrics['prompt_start'] + @lyrics[@difficulty]}"
      guess = gets.chomp
      if guess == "exit"
        game_over
      else
        guess = guess.to_i
      end
    end

    validate_guess(guess)
  end

  def medium_mode
    validate_guess(get_guess)
  end

  def hard_mode
    validate_guess(get_guess)
  end

  def get_guess
    guess = 0
    puts "#{@lyrics['prompt_start'] + @lyrics[@difficulty]}"
    guess = gets.chomp
    game_over if guess == "exit"

    guess
  end

  def validate_guess(guess)
    if guess == @lyrics["#{@difficulty}_answer"]
      puts "Correct!"
    else
      puts @lyrics['lose_text']
    end
  end

  def game_over
    puts "Sorry to see you go! Have a good day!"
    exit
  end
end

game = GuessingGame.new.play

puts "Would you like to play again?"
gets.chomp.downcase[0] == "y" ? game = GuessingGame.new.play : exit
