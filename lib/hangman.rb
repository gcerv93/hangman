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
