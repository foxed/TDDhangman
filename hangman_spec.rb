require 'rspec'
require 'set'

class WordFile
  def self.select_word
    word_file = File.open("/usr/share/dict/words", "r")
    word_bank = []
    word_file.each { |line| word_bank << line }
    selected_word = word_bank.sample.strip
  end
end

class Guess
  def get_guess
    puts "guess the letters in the word..."
    @guess = STDIN.gets.chomp
  end
end

class Game
  attr_accessor :word

  def initialize
    print "Welcome to Fox Hangman"
    @word = WordFile.select_word
  end
end

describe 'game' do
  it 'greets the player upon starting' do
    expect { Game.new }.to output("Welcome to Fox Hangman").to_stdout
  end

  it 'selects a word' do
    game = Game.new

    expect(game.word).to_not be_nil
  end
end
