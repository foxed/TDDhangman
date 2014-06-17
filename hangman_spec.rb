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
    print "Guess the letters in the word..."
    @guess = STDIN.gets.chomp
  end
end

class Game
  attr_accessor :word, :letters

  def initialize
    print "Welcome to Fox Hangman"
    @word = WordFile.select_word
    @letters = @word.split ""
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

  it 'selects letters from word' do
    game = Game.new

    expect(game.letters.count).to eq(game.word.size)
  end
end

describe 'guess' do
  it 'gets guess from player' do
    guess = Guess.new

    expect(guess.get_guess).to_not be_nil
  end

  it 'player gets correct guess' do
    guess = Guess.new
    letters = WordFile.select_word.split ""

    expect(letters).to include(guess.get_guess)
  end

  it 'player gets incorrect guess' do
    guess = Guess.new
    letters = WordFile.select_word.split ""

    expect(letters).to_not include(guess.get_guess)
  end
end
