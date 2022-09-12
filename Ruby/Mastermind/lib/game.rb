# frozen_string_literal: true

# lib/game.rb
require 'colorize'
require_relative 'code_maker'
require_relative 'code_breaker'

# Game Class
class Game
  attr_reader :player_name

  def start
    puts "\n--- WELCOME TO MASTERMIND ---"
    @player_name = ask_for_player_name
    play
  end

  def play
    game_mode = mode_choice
    code_maker if game_mode == '1'
    code_breaker if game_mode == '2'
    play if play_again
  end

  def mode_choice
    puts "\nGAME MODES"
    puts '1. Code Maker: You set the code and the Computer guesses it'
    puts "2. Code Breaker: Computer sets the code and you try to break it.\n"
    puts 'Which mode would you like to play [1/2]'
    answer = gets.chomp
    return answer if answer.match(/^[1-2]$/)

    puts 'Invalid answer'
    mode_input
  end

  def code_maker
    puts "\nYou are the Code Maker."
    CodeMaker.new(player_name).play
  end

  def code_breaker
    puts "\nYou are the Code Breaker"
    puts 'After each guess you will receive the following feedback:'
    puts '* - Exact match of colour and position.'
    puts '? - Correct colour, wrong position.'
    puts 'Enter your guesses in the format XXXX.'
    puts "Your options are #{'R'.colorize(:red)}|#{'W'.colorize(:white)}|#{'Y'.colorize(:yellow)}|#{'G'.colorize(:green)}|#{'B'.colorize(:blue)}|#{'I'.colorize(:magenta)}"
    CodeBreaker.new(player_name).play
  end

  def ask_for_player_name
    puts "\nTo get started please enter your name:\n"
    gets.chomp
  end

  def play_again
    puts 'Would you like to play another game? [Y/N]'
    answer = gets.chomp
    answer.downcase == 'y'
  end
end
