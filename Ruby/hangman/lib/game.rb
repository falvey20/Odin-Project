# frozen_string_literal: true

# lib/main.rb

require_relative 'hangman'
require 'json'
require 'io/console'

# Game Class
class Game
  def start
    puts "\n--- WELCOME TO HANGMAN ---"
    mode_choice
  end

  def mode_choice
    new_or_saved = choose_new_or_saved
    load_saved_game if new_or_saved == '1'
    new_game if new_or_saved == '2'
  end

  def new_game
    @game = Hangman.new
    @game.rules
    play
  end

  def play
    puts "WORD: #{@game.found_chars}"
    while @game.turn >= 1
      @game.guessed_letter = @game.guess_letter
      puts "GUESS : #{@game.guessed_letter}"
      @game.check_guess(@game.random_word, @game.guessed_letter)

      if @game.solution_found(@game.random_word, @game.found_chars)
        @game.congratulations_message
        break
      end

      @game.hangman_diagram(@game.turn)
      @game.show_found_letters
      @game.show_attempted_letters
      @game.remaining_turns
      @game.clear_guess
      want_to_save
    end
    new_game if play_again
  end

  def choose_new_or_saved
    puts "\nSelect which you would like to play [1/2]"
    puts '1: Saved Game'
    puts '2: New Game'
    answer = gets.chomp
    return answer if answer.match(/^[1-2]$/)

    puts 'Invalid answer!'
    choose_new_or_saved
  end

  def play_again
    puts "\nWould you like to play a new game? [Y/N]"
    answer = gets.chomp
    answer.downcase == 'y'
  end

  def want_to_save
    puts "\nIf you would like to save type 'save', otherwise hit return to continue."
    input = gets.chomp.upcase
    save_game if input == 'SAVE'
  end

  def save_game
    File.open('save_game.json', 'w') do |file|
      file.puts(game_to_json)
    end
    puts 'Game Saved!'
  end

  def game_to_json
    JSON.dump({
                word: @game.random_word,
                correct_letters: @game.correct_letters,
                incorrect_letters: @game.incorrect_letters,
                found_chars: @game.found_chars,
                turn: @game.turn
              })
  end

  def from_json(save_game_file)
    game_data = JSON.parse(File.read(save_game_file))
    @game = Hangman.new(
      game_data['word'],
      game_data['correct_letters'],
      game_data['incorrect_letters'],
      game_data['found_chars'],
      game_data['turn']
    )
  end

  def load_saved_game
    unless File.exist?('save_game.json')
      puts 'You have no saved game'
      play_again
    end

    File.open('save_game.json', 'r') do |file|
      from_json(file)
    end
    File.delete('save_game.json')

    puts 'Saved game loaded successfully.'
    @game.hangman_diagram(@game.turn)
    @game.show_found_letters
    puts @game.incorrect_letters

    play
  end
end
