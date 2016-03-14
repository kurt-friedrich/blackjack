# code refactored based on examples from 3/10 lecture

# Makes 52 card deck with Blackjack values
class Card
  attr_accessor :face, :suit, :value

  def initialize(face, suit)
    self.face = face
    self.suit = suit
    self.value = values[face]
  end

  def self.faces
    %w(2 3 4 5 6 7 8 9 10 J Q K A)
  end

  def self.suits
    %w(clubs diamonds hearts spades)
  end

  def values
    { '2' => 2,  '3' => 3,   '4' => 4,
      '5' => 5,  '6' => 6,   '7' => 7,
      '8' => 8,  '9' => 9,   '10' => 10,
      'J' => 10, 'Q' => 10,  'K' => 10,
      'A' => 11
    }
  end

  def >(other)
    value > other.value
  end
end
