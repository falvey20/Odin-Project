# frozen_string_literal: true

# 'lib/hangman.rb'

require 'colorize'
require_relative 'hangman_display'

# Hangman Class
class Hangman
  include HangmanDisplay
  attr_accessor :random_word, :found_chars, :incorrect_letters, :correct_letters, :turn, :guessed_letter

  def initialize(word = select_random_word, correct_letters = [], incorrect_letters = [], found_chars = '_' * word.length, turn = 6)
    @random_word = word
    @found_chars = found_chars
    @correct_letters = correct_letters
    @incorrect_letters = incorrect_letters
    @turn = turn
  end

  def rules
    puts "\nYou will have 6 guesses."
    puts "\nGood Luck!"
  end

  def select_random_word
    dictionary = File.readlines('google-10000-english-no-swears.txt', chomp: true)
    selected = ''
    selected = dictionary.sample until selected.length.between?(5, 12)
    selected.upcase
  end

  def guess_letter
    puts 'Enter your guess.'
    input = gets.chomp.upcase

    if input.length != 1 || input.count('a-zA-Z') != 1
      puts 'Invalid Input: You can only choose ONE letter for each guess.'
      guess_letter
    elsif correct_letters.include?(input) || incorrect_letters.include?(input)
      puts "You have already guessed '#{input}' before, try again."
      guess_letter
    else
      input
    end
  end

  def check_guess(random_word, guessed_letter)
    if random_word.include?(guessed_letter)
      correct_letters << guessed_letter
      random_word.chars.each_with_index do |char, idx|
        found_chars[idx] = char if char == guessed_letter
      end
    else
      incorrect_letters << guessed_letter
      @turn -= 1
    end
  end

  def show_found_letters
    puts "Secret Word: #{found_chars}"
  end

  def show_attempted_letters
    puts "#{'Correct Letters:'.colorize(:green)} #{@game.correct_letters}"
    puts "#{'Incorrect Letters:'.colorize(:red)} #{@game.incorrect_letters}"
  end

  def remaining_turns
    remaining = turn
    case remaining
    when 0
      puts "\nUnlucky, you lost this time :( the code was: #{random_word}"
    when 1
      puts 'This is your final guess!'
    else
      puts "You have #{turn} turns remaining."
    end
  end

  def clear_guess
    @guessed_letter = ''
  end

  def solution_found(random_word, found_chars)
    random_word == found_chars
  end

  def congratulations_message
    puts "\nNice work, you stopped the hangman! The secret word was: #{random_word}"
  end

  def hangman_diagram(turn)
    case turn
    when 6
      puts HangmanDisplay::HM_ZERO
    when 5
      puts HangmanDisplay::HM_ONE
    when 4
      puts HangmanDisplay::HM_TWO
    when 3
      puts HangmanDisplay::HM_THREE
    when 2
      puts HangmanDisplay::HM_FOUR
    when 1
      puts HangmanDisplay::HM_FIVE
    when 0
      puts HangmanDisplay::HM_SIX
    end
  end
end
