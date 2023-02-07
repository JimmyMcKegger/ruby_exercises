#!/usr/bin/env ruby
# frozen_string_literal: true

# Tic Tac Toe game for the Odin Project

require 'colorize'

class TicTacToe
  def initialize
    @board = [
      %w[1 2 3],
      %w[4 5 6],
      %w[7 8 9]
    ]
    @x = Player.new('X')
    @o = Player.new('O')
    @players = [@x, @o]
    @spaces_remaining = 9
    @map_to_index = {
      1 => [0, 0],
      2 => [0, 1],
      3 => [0, 2],
      4 => [1, 0],
      5 => [1, 1],
      6 => [1, 2],
      7 => [2, 0],
      8 => [2, 1],
      9 => [2, 2]
    }
  end

  class Player
    def initialize(name)
      @name = name
      @win = false
    end
    attr_reader :name

    def wins!
      @win = true
    end

    def won?
      @win
    end
  end

  def show_board
    puts "
    -----------------
     _#{@board[0][0]}_ | _#{@board[0][1]}_ | _#{@board[0][2]}_
     _#{@board[1][0]}_ | _#{@board[1][1]}_ | _#{@board[1][2]}_
     _#{@board[2][0]}_ | _#{@board[2][1]}_ | _#{@board[2][2]}_
    -----------------".colorize(:blue).bold.on_black
  end

  def play
    turn_order = [@x, @o]
    until @players.any?(&:won?) || @spaces_remaining.zero?
      show_board
      current_player = @players[0]
      round(current_player)
      check_for_win(current_player)
    end
    result
  end

  private

  def round(player)
    puts "\nStarting round for #{player.name}"
    pick = -1
    until (1..9).include?(pick)
      puts 'Pick an numbered space:'
      pick = gets.to_i
    end
    row, column = index_on_board(pick)
    if @board[row][column].to_i.positive?
      @board[row][column] = player.name
      @spaces_remaining -= 1
      @players.rotate!
    else
      puts 'Invalid choice'.colorize(:red)
    end
  end

  def result
    if @x.won?
      puts 'Player X wins!'.colorize(:green)
    elsif @o.won?
      puts 'Player O wins!'.colorize(:green)
    else
      puts 'Draw.'.colorize(:yellow)
    end
  end

  def index_on_board(num)
    @map_to_index[num]
  end

  def check_for_win(player)
    # 3 rows, 3 columns, 2 diagonals
    winning_line = Array.new(3, player.name)
    winning_test = proc { |line| line == winning_line }

    diagonals = [@board.flatten.values_at(0, 4, 8), @board.flatten.values_at(2, 4, 6)]
    return player.wins! if diagonals.any?(winning_line)

    3.times do |i|
      return player.wins! if winning_test.call(@board[i]) || winning_test.call(@board.transpose[i])
    end
  end
end

game = TicTacToe.new
game.play
