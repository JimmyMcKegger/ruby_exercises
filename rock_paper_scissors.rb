#!/usr/bin/ruby
# Rock paper scissors game
class RockPaperScissors
  def initialize
    @player1_pick = nil
  end
  def play
    until @player1 == "rock" || @player1 == "paper" || @player1 == "scissors"
      puts "Pick 'Rock', 'Paper', or 'Scissors': "
      @player1 = gets.chomp.downcase
    end
    random_result(@player1)
  end
  private
  def random_result(p1_pick)
    puts ["Woohoo! You win", "Say it ain’t so… you lost", "Looks like a draw"].sample
  end
end

game = RockPaperScissors.new
game.play
