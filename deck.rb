require './card'
#code refactored based on examples from 3/10 lecture

class Deck
  attr_accessor :cards

  def initialize
    fill_deck
    shuffle
  end

  def fill_deck
    self.cards = []
    Card.suits.each do |suit|
      Card.faces.each do |face|
        self.cards << Card.new(face, suit)
      end
    end
  end

  def dry?
    cards.empty?
  end

  def split
  end

  def shuffle
    cards.shuffle!
  end

end
