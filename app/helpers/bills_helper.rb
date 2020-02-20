module BillsHelper
  def bills_index_header_names
    ['Date range', 'Fee per game', 'Total amount']
  end

  def bills_index_header_methods
    %w[date_range fee_per_game total_amount]
  end

  def update_bill_amounts(bill)
    bill.bill_amounts.each { |ba| ba.update!(amount: 0) }
    generate_bill_amounts(bill)
    bill.bill_amounts.each { |ba| ba.destroy! if ba.amount.zero? }
  end

  def generate_bill_amounts(bill)
    date_range = bill.from_date.beginning_of_day..bill.to_date.end_of_day
    games = Game.where(played_on: date_range)
    fee_per_game = bill.fee_per_game
    players_count_in_all_games = games.inject(0) { |count, game| count + game.players.count }
    fee_per_player_per_game = (games.count * fee_per_game) / players_count_in_all_games

    games.each do |game|
      players = game.players

      players.each do |player|
        player_id = player.id

        if bill.bill_amounts.exists?(player_id: player_id)
          player_bill_amount = bill.bill_amounts.where(player_id: player_id).last
          updated_amount = player_bill_amount.amount + fee_per_player_per_game

          player_bill_amount.update!(amount: updated_amount)
        else
          bill_amount = { player_id: player_id, amount: fee_per_player_per_game }

          bill.bill_amounts.create!(bill_amount)
        end
      end
    end
  end
end
