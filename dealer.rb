require './deck'
require './player'

class Dealer < Player

  def initialize(name)
    self.name = name
    self.hand = []
    self.pile = []
    self.deck = new_deck
  end

  def deal(num=1)
    card = deck.shift(num)
    num == 1 ? card.first : card
  end

end
