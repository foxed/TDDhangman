require 'rspec'
require 'set'

class WordFile
  def self.select_word
    word_bank = File.open("/usr/share/dict/words", "r").to_a
  end
end

class Guess
  def initialize(guess)
    print "Guess the letters in the word..."
    @guess = STDIN.gets.chomp
  end
end

class Game
  attr_accessor :letters

  def initialize(word)
    print "Welcome to Fox Hangman"
    @letters = word.split ""
  end
end

describe Game do
  describe '.initialize' do
    it 'greets the player upon starting' do
      word = "blah"

      expect { Game.new(word) }.to output("Welcome to Fox Hangman").to_stdout
    end

    it 'selects a word' do
      word = "blah"
      game = Game.new(word)

      expect(game).to_not be_nil
    end

    it 'returns the word split into characters' do
      word = "blah"
      game = Game.new(word)

      expect(game.letters).to eq %w(b l a h)
    end
  end
end

describe Guess do
  describe '.initialize' do
    it 'gets guess from player' do
      input = "blah"
      guess = Guess.new(input)

      expect(guess).to_not be_nil
    end

    it 'player gets correct guess' do
      word = "blah"
      guessed_letter = "a"
      guess = Guess.new(guessed_letter)
      game = Game.new(word)

      expect(game.letters).to include(guessed_letter)
    end

    it 'player gets incorrect guess' do
      word = "blah"
      guessed_letter = "z"
      guess = Guess.new(guessed_letter)
      game = Game.new(word)

      expect(game.letters).to_not include(guess)
    end
  end
end
