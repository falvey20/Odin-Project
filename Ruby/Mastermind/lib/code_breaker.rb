# frozen_string_literal: true

# lib/code_breaker.rb

require_relative 'logic'

# Class for Code Breaker Mode
class CodeBreaker
  attr_accessor :random_code, :turn, :guess, :player_name

  include Logic

  def initialize(player_name)
    @player_name = player_name
    @random_code = generate_code
    @turn = 1
  end

  def generate_code
    [Logic::COLOURS.sample, Logic::COLOURS.sample, Logic::COLOURS.sample, Logic::COLOURS.sample]
  end

  def play
    while turn <= 12
      @guess = player_guess
      if solution_found?(random_code, guess)
        congratulations_message
        break
      end
      check_guess(random_code, guess)
      show_clues(exact_num, same_num)
      remaining_turns(turn)
      clear_guess
      @turn += 1
    end
  end

  def player_guess
    if turn == 1
      puts "\nPlease enter your first guess"
    else
      puts "\nEnter your next guess."
    end
    input = gets.chomp
    if input.length != 4 || input.count('RWYGBI') != 4
      puts 'Invalid Input, remember to use the format XXXX'
      player_guess
    end
    input.chars
  end

  def clear_guess
    @guess = ''
  end

  def congratulations_message
    puts "\nCongratulations #{player_name}, you correctly found #{random_code.join}, you win!!!\n"
  end

  def remaining_turns(turn)
    remaining = 12 - turn
    case remaining
    when 0
      puts "\nUnlucky #{player_name}, you lost this time :(, the code was #{random_code.join}"
    when 1
      puts "\nThis is your final guess!"
    else
      puts "\nYou have #{12 - turn} turns remaining."
    end
  end
end
