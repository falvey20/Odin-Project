# frozen_string_literal: true

# lib/game.rb

require_relative 'player'
require_relative 'board'

# Game Class
class Game
  attr_reader :game_board, :player_one, :player_two, :moves, :current_player

  def initialize
    @game_board = Board.new
    @moves = 1
  end

  def game_loop
    while @moves <= 9
      move = game_move
      game_board.update_board(current_player.symbol, move)
      if current_player.player_win?(game_board)
        current_player.congratulate_winner
        break
      end
      @current_player = change_current_player
      @moves += 1
    end
  end

  def game_move
    current_player.player_move
  end

  def start_game
    puts "\nWelcome to Tic-Tac-Toe"
    enter_player_one
    enter_player_two
    game_board.show_board
    game_loop
    tie_message if moves == 10
    ask_for_new_game
  end

  def enter_player_one
    puts "\nPlayer one, what is your name?"
    @player_one = Player.new(gets.chomp, 'X')
    @current_player = player_one
    puts "\n"
  end

  def enter_player_two
    puts "\nPlayer two, what is your name?"
    @player_two = Player.new(gets.chomp, 'O')
    puts "\n"
  end

  def change_current_player
    current_player == player_one ? player_two : player_one
  end

  def tie_message
    puts "\nIt's a tie, no moves remaining.\n"
  end

  def ask_for_new_game
    puts "\nWould you like to play a new game? [Y/N]"
    answer = gets.chomp
    answer = gets.chomp until answer.downcase == 'y' || answer.downcase == 'n'
    if answer.downcase == 'y'
      Game.new.start_game
    else
      puts "\nThanks for playing, Bye!\n"
    end
  end
end

game = Game.new
game.start_game
