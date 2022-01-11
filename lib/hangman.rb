# frozen_string_literal: true

# class for the display
class Display
  attr_accessor :head, :arms, :body, :legs, :game_word

  def initialize
    @head = '	 O'
    @arms = '	/ \\'
    @body = '	 |'
    @legs = '	/ \\'
    @game_word = []
  end

  def draw_hangman
    puts head
    puts arms
    puts body
    puts legs
  end

  def create_game_word(wrd_length)
    wrd_length.times { game_word << '_' }
  end

  def update_game_word(idx, letter)
    game_word[idx] = letter
  end

  def display_game_word
    puts game_word.join(' ')
  end

  def display_guessed_letters(letters)
    guessed_string = 'Wrong guesses:'
    letters.each { |chr| guessed_string += " #{chr}" }
    puts guessed_string
  end
end

# class for the game logic
class Game
  attr_reader :display, :word

  def initialize
    @display = Display.new
    @word = word_generator
    @guess_count = 0
    @guessed_letters = []
  end

  def word_generator
    word = File.readlines('5desk.txt').sample.chomp
    return word.downcase if word.length >= 5 && word.length <= 12

    word_generator
  end
end
