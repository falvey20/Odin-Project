# frozen_string_literal: true

# lib/code_maker.rb

require_relative 'logic'
require 'colorize'

# Class for Code Maker Mode
class CodeMaker
  attr_accessor :all_permutations, :chosen_code, :computer_guess, :turn, :player_name

  include Logic

  def initialize(player_name)
    @player_name = player_name
    @turn = 1
  end

  def play
    instructions
    @chosen_code = choose_code

    @all_permutations = generate_all_permutations
    puts "There are #{all_permutations.size} possible codes."
    while turn <= 12
      @computer_guess = ask_for_computer_guess
      puts "\nGuess ##{turn}: #{computer_guess.join}"
      if solution_found?(chosen_code, computer_guess)
        computer_wins
        break
      end
      check_guess(chosen_code, computer_guess)
      show_clues(exact_num, same_num)
      eliminate_impossible_permutations(computer_guess, exact_num, same_num)
      puts "There are #{all_permutations.size} possible combinations left."
      clear_computer_guess
      @turn += 1
    end
  end

  def instructions
    puts "\nChoose your code in the format XXXX"
    puts "You can choose any combination of #{'R'.colorize(:red)}|#{'W'.colorize(:white)}|#{'Y'.colorize(:yellow)}|#{'G'.colorize(:green)}|#{'B'.colorize(:blue)}|#{'I'.colorize(:magenta)}"
  end

  def choose_code
    input = gets.chomp
    if input.length != 4 || input.count('RWYGBI') != 4
      puts 'Invalid Input, remember to use the format XXXX'
      choose_code
    end
    input.chars
  end

  def generate_all_permutations
    Logic::COLOURS.repeated_permutation(4).to_a
  end

  def ask_for_computer_guess
    all_permutations.sample
  end

  def clear_computer_guess
    computer_guess = []
  end

  def computer_wins
    puts "\nThe Computer solved #{player_name}'s code in #{turn} turns. The code was #{chosen_code}\n"
  end
end
