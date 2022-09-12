# frozen_string_literal: true

# lib/game.rb

# Module for Mastermind Game Logic
module Logic
  COLOURS = %w[R W Y G B I].freeze

  attr_accessor :exact_num, :same_num

  def check_guess(solution, guess)
    temp_solution = solution.clone
    temp_guess = guess.clone
    @exact_num = exact_check(temp_solution, temp_guess)
    @same_num =  same_check(temp_solution, temp_guess)
  end

  def exact_check(temp_solution, temp_guess)
    exact = 0
    temp_solution.each_with_index do |i, j|
      next unless i == temp_guess[j]

      exact += 1
      temp_solution[j] = '*'
      temp_guess[j] = '*'
    end
    exact
  end

  def same_check(temp_solution, temp_guess)
    same = 0
    temp_guess.each_index do |i|
      next unless temp_guess[i] != '*' && temp_solution.include?(temp_guess[i])

      same += 1
      remove = temp_solution.find_index(temp_guess[i])
      temp_solution[remove] = '?'
      temp_guess[i] = '?'
    end
    # puts "solution in same_check_guess #{solution}"
    # puts "guess in same_check_guess #{guess}"
    same
  end

  def solution_found?(solution, guess)
    solution == guess
  end

  def show_clues(exact, same)
    print 'Clues: '
    exact.times { print '*' }
    same.times { print '?' }
    puts ''
    # puts "exact is #{exact_num}"
    # puts "Same is #{same_num}"
  end

  # Taken from Donald Knuth Algorithm
  def eliminate_impossible_permutations(computer_guess, exact, same)
    all_permutations.select! do |p|
      check_guess(p, computer_guess)
      (exact == exact_num && same == same_num)
    end
  end
end
