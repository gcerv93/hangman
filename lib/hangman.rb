# frozen_string_literal: true

# class for the display
class Display
  attr_accessor :head, :arms, :body, :legs

  def initialize
    @head = '	 O'
    @arms = '	/ \\'
    @body = '	 |'
    @legs = '	/ \\'
  end

  def draw_hangman
    puts head
    puts arms
    puts body
    puts legs
  end
end

# class for the game logic
class Game
  attr_reader :display, :word

  def initialize
    @display = Display.new
    @word = word_generator
  end

  def word_generator
    word = File.readlines('5desk.txt').sample.chomp
    return word.downcase if word.length >= 5 && word.length <= 12

    word_generator
  end
end
