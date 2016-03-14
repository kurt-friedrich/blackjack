require './dealer'
#require './deck'
#require './player'
#require './card'

class Game
  attr_accessor :dealer, :dhand, :dscore, :player, :phand, :pscore, :stand

  def initialize
    self.dealer = Dealer.new("Dealer")
    self.player = Player.new("Player")
  end

  def play
    clear_table
    deal_cards
    display_cards
    player_turn
    dealer_turn if pscore <= 21 && self.stand == true
    replay?
  end

  def player_turn
    if pscore == 21
      blackjack
    else
      while self.stand == false
        if pscore <= 21
          hit?
        else
          bust
          break
        end
      end
    end
  end

  def dealer_turn
    dealer_flip
    display_score
    if dscore == 21
      dblackjack
    else
      while dscore <= 21
        if dscore < 16 && dscore <= pscore
          puts "hit [enter] for next card"
          STDIN.gets
          dhit
        else
          break
        end
      end
      winner?
    end
  end

  def blackjack
    first_score
    puts "BLACKJACK! #{player.name} wins!"
  end

  def dblackjack
    puts "DEALER BLACKJACK! #{dealer.name} wins :("
  end

  def bust
    puts first_score
    puts "BUST! #{dealer.name} wins :("
  end

  def clear_table
    self.phand = []
    self.dhand = []
    self.pscore = 0
    self.dscore = 0
    self.stand = false
    dealer.new_deck.shuffle
  end

  def deal_cards
    self.phand = dealer.deal(2)
    self.dhand = dealer.deal(2)
    self.pscore = phand.inject(0) { |sum, card| sum + card.value }
    self.dscore = dhand.inject(0) { |sum, card| sum + card.value }
  end

  def dealer_flip
    puts ""
    puts "DEALER CARDS"
    puts "----------"
    puts "#{dhand[0].face} of #{dhand[0].suit.upcase}"
    puts "#{dhand[1].face} of #{dhand[1].suit.upcase}"
    puts ""
  end

  def display_cards
    dcard1 = dhand[0]
    puts "~~~~~~~~~~ NEW GAME ~~~~~~~~~~"
    puts ""
    puts "PLAYER CARDS"
    puts "-------------"
    #phand.each.with_index do |card, i|
    #  puts "Card #{i + 1}: #{card.face} of #{card.suit.upcase}"
    #end
    phand.each do |card|
      puts "#{card.face} of #{card.suit.upcase}"
    end
    puts ""
    puts "DEALER CARDS"
    puts "-------------"
    puts "#{dcard1.face} of #{dcard1.suit.upcase}"
    puts ""
  end

  def display_score
    puts "PLAYER: #{pscore} | DEALER: #{dscore}"
  end

  def first_score
    puts "PLAYER: #{pscore} | DEALER: #{dhand[0].value}"
  end

  def dhit
    self.dhand << dealer.deal
    puts "#{dhand.last.face} of #{dhand.last.suit.upcase}"
    puts ""
    update_dscore
    display_score
  end

  def hit
    self.phand << dealer.deal
    puts ""
    puts "#{phand.last.face} of #{phand.last.suit.upcase}"
    update_pscore
  end

  def hit?
    first_score
    puts "Do you want to [hit] or [stand]?"
    answer = gets.chomp.downcase
    if answer == 'hit'
      hit
    elsif answer == 'stand'
      self.stand = true
    end
  end

  def replay?
    puts "Do you want to play again? [y/n]"
    answer = gets.chomp
    if answer == 'y'
      play
    elsif answer == 'n'
      puts "thanks for playing"
    end
  end

  def update_dscore
    self.dscore += dhand.last.value
  end

  def update_pscore
    self.pscore += phand.last.value
  end

  def winner?
    if dscore > 21 || pscore > dscore
      puts "#{player.name} wins!"
    elsif dscore > pscore
      puts "#{dealer.name} wins :("
    else
      puts "Draw!"
    end
  end

end

Game.new.play
