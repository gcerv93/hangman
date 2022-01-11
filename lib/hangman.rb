# frozen_string_literal: true

# class for player inputs
class Player
  def player_guess
    puts 'Please input a letter: '
    answer = gets.chomp
    if answer.match(/[a-zA-Z]/) && answer.length == 1
      answer.downcase
    else
      player_guess
    end
  end
end

# class for the display
class Display
  attr_accessor :hangman, :game_word

  def initialize
    @hangman = ['	 O', ['	/ ', '\\'], '	 |', ['	/', ' \\']]
    @game_word = []
  end

  def draw_hangman
    puts "\n\n"
    hangman.each do |part|
      if part.is_a?(Array)
        puts part.join('')
      else
        puts part
      end
    end
  end

  def create_game_word_display(wrd_length)
    wrd_length.times { game_word << '_' }
  end

  def update_game_word(idx, letter)
    game_word[idx] = letter
  end

  def display_game_word
    print "\n   #{game_word.join(' ')}"
  end

  def display_guessed(letters)
    guessed_string = 'Already guessed:'
    letters.each { |chr| guessed_string += " #{chr}" }
    print "         #{guessed_string}\n\n"
  end

  # only need to run on a wrong guess, so num should never be 0
  def update_hangman(num)
    if num == 6
      hangman[0] = ''
    elsif num.between?(4, 5)
      hangman[1].pop
    elsif num == 3
      hangman[2] = ''
    else
      hangman[3].pop
    end
  end

  def join_game_word
    game_word.join('')
  end
end

# class for the game logic
class Game
  attr_accessor :guessed_letters
  attr_reader :display, :word, :wrong_guesses, :player

  def initialize
    @display = Display.new
    @player = Player.new
    @word = word_generator
    @wrong_guesses = 0
    @guessed_letters = []
  end

  def word_generator
    word = File.readlines('5desk.txt').sample.chomp
    return word.downcase if word.length >= 5 && word.length <= 12

    word_generator
  end

  def check_player_guess(guess)
    if word.include?(guess) && guessed_letters.include?(guess) == false
      correct_player_guess(guess)
    elsif word.include?(guess) == false && guessed_letters.include?(guess) == false
      wrong_player_guess(guess)
    else
      puts "Please input a different letter!\n\n"
      check_player_guess(player.player_guess)
    end
    update_guessed_letters(guess)
  end

  def update_guessed_letters(guess)
    guessed_letters << guess unless guessed_letters.include?(guess)
  end

  def correct_player_guess(guess)
    index_of_letter(guess).each { |idx| display.update_game_word(idx, guess) }
  end

  def wrong_player_guess(guess)
    puts "Sorry! #{guess} isn't in my word :("
    @wrong_guesses += 1
    display.update_hangman(wrong_guesses)
  end

  def index_of_letter(letter)
    (0...word.length).find_all { |i| word[i] == letter }
  end

  def game_start
    display.create_game_word_display(word.length)
  end

  def game_round
    display.draw_hangman
    display.display_game_word
    display.display_guessed(guessed_letters)
    check_player_guess(player.player_guess)
  end

  def win?
    display.join_game_word == word
  end
end
