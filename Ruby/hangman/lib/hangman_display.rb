# frozen_string_literal: true

# 'lib/hangman_display.rb'

# Module for displaying hangman stages
module HangmanDisplay
  HM_ZERO = %q(
    _________
    |/      |
    |
    |
    |
    |
    |
    |\____
  )

  HM_ONE = %q{
    _________
    |/      |
    |      (_)
    |
    |
    |
    |
    |\____
  }
  HM_TWO = %q{
    _________
    |/      |
    |      (_)
    |       |
    |       |
    |
    |
    |\____
  }
  HM_THREE = %q{
    _________
    |/      |
    |      (_)
    |      \|
    |       |
    |
    |
    |\____
  }
  HM_FOUR = %q{
    _________
    |/      |
    |      (_)
    |      \|/
    |       |
    |
    |
    |\____
  }
  HM_FIVE = %q{
    _________
    |/      |
    |      (_)
    |      \|/
    |       |
    |      /
    |
    |\____
  }

  HM_SIX = %q{
    _________
    |/      |
    |      (_)
    |      \|/
    |       |
    |      / \
    |
    |\____
  }
end
