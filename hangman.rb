require 'set'

class Hangman
  attr_reader :guess, :letters

  def initialize(filename)
    word_file = File.open(filename, "r")
    word_bank = []
    word_file.each { |line| word_bank << line}
    selected_word = word_bank.sample.strip
    @letters = selected_word.split ''
    @guesses = [].to_set
  end

  def play
    while !game_over?
      display_status
      get_guess
    end
    display_verdict
  end

  private

  def game_over?
    won? || lost?
  end

  def won?
   @letters.all? do |letter|
     @guesses.include?(letter)
   end
  end

  def lost?
    incorrect_guesses > 6
  end

  def incorrect_guesses
    (@guesses - @letters).length + 1
  end

  def display_status
    display_remaining_guesses
    display_guessed_letters
    display_board
  end

  def display_remaining_guesses
    remaining_guesses =  6 - (@guesses - @letters).length
    puts "You have #{remaining_guesses} guesses left."
  end

  def display_guessed_letters
    puts @guesses.sort.join(" ")
  end

  def display_board
    @letters.each do |letter|
      if(@guesses.include? letter)
        print "#{letter}"
      else
        print " - "
      end
    end
    puts
  end

  def get_guess
    guess = gets.chomp.downcase
    @guesses << guess
  end

  def display_verdict
    if won?
      "Congratulations! You won!"
    else
      puts "Sorry, you lost. The word was '#{@letters.join.upcase}'."
    end
  end
end

game = Hangman.new("/usr/share/dict/words")
game.play
