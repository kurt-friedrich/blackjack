require './deck'
require './player'

class Game
  attr_accessor :player_one, :player_two, :rounds, :wars, :winner

  def initialize
    self.player_one = Player.new("buddy")
    self.player_two = Player.new("guy")
  end

  def play
    clear_totals
    deal_cards
    play_game
    get_winner
    results
  end

  def clear_totals
    self.rounds = 0
    self.wars = 0
    player_one.pile = []
    player_two.pile = []
  end

  def deal_cards
    player_one.deal
    player_two.deal
  end

  def play_game
    until player_one.dry?
      self.rounds += 1
      hand1 = player_one.draw
      hand2 = player_two.draw
      pot = [hand1, hand2]

      if hand1 > hand2
        player_one.wins(pot)
      elsif hand2 > hand1
        player_two.wins(pot)
      else
        self.wars += 1
      end
    end
  end

  def get_winner
    if player_one.cards_won > player_two.cards_won
      self.winner = "Player 1"
    elsif player_one.cards_won < player_two.cards_won
      self.winner = "Player 2"
    else
      self.winner = "Nobody"
    end
  end

  def results
    puts "#{winner} won this game after #{rounds} rounds and survived #{wars} WARs. Would you like a rematch (y/n)?"
    play if gets.chomp.downcase == 'y'
  end

end

Game.new.play
