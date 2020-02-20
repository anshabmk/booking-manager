class Game < ApplicationRecord
  has_and_belongs_to_many :players

  def parsed_played_on_date
    played_on.strftime('%d %b %Y')
  end

  def parsed_time_slot
    hour = time_slot / 100
    minutes = (time_slot % 100).to_s.ljust(2, '0')

    return "#{hour - 12}:#{minutes} PM" if hour >= 12

    "#{hour}:#{minutes} AM"
  end

  def parsed_duration
    unit = duration > 1 ? 'hours' : 'hour'

    "#{duration} #{unit}"
  end

  def players_count
    player_ids.count
  end
end
