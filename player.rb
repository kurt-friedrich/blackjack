require './deck'
#code refactored based on examples from 3/10 lecture

class Player
  attr_accessor :name, :deck, :hand, :pile

  def initialize(name)
    self.name = name
    self.hand = []
    self.pile = []
  end

  def cards_won
    pile.length
  end

  def draw(num=1)
    card = deck.shift(num)
    num == 1 ? card.first : card
  end

  def dry?
    deck.dry?
  end

  def new_deck
   self.deck = Deck.new.cards
  end

  def shuffle
    deck.shuffle
  end

  def wins(cards)
    self.pile += cards
  end

end
