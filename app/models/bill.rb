class Bill < ApplicationRecord
  has_many :bill_amounts, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  def strf_date_range
    from_date_parsed = parse_date(from_date)
    to_date_parsed = parse_date(to_date)

    "#{from_date_parsed} - #{to_date_parsed}"
  end

  def date_range
    from_date..to_date
  end

  def total_amount
    bill_amounts.inject(0.0) do |sum, bill_amount|
      sum + bill_amount.amount
    end
  end

  def games
    Game.where(played_on: date_range)
  end

  def players_count_in_all_games
    games.inject(0) { |count, game| count + game.players_count }
  end

  def fee_per_player_per_game
    ((games.count * fee_per_game) / players_count_in_all_games).ceil
  end

  def update_bill_amounts
    bill_amounts.each { |ba| ba.update!(amount: 0) }
    generate_bill_amounts
    bill_amounts.each { |ba| ba.destroy! if ba.amount.zero? }
  end

  def generate_bill_amounts
    player_bill_amounts = games.each_with_object({}) do |game, amounts|
      player_ids = game.player_ids

      player_ids.each do |player_id|
        amounts[player_id] = amounts[player_id].to_f + fee_per_player_per_game
      end
    end

    player_bill_amounts.each do |player_id, amount|
      bill_amounts.create!(player_id: player_id, amount: amount)
    end
  end

  def send_notification_message
    bill_amounts.each do |ba|
      mobile_number = ba.player.mobile_number

      next if mobile_number.blank?

      res = Notifier::SMS.send(mobile_number, ba.notification_message_content)

      Rails.logger.info res.inspect
    end
  end

  private

  def parse_date(date)
    date&.strftime('%d %b %Y')
  end
end
