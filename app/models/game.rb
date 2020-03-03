class Game < ApplicationRecord
  has_and_belongs_to_many :players

  validates :played_on, presence: true
  validates :time_slot, presence: true
  validates :duration, presence: true

  validate :unique_played_on_and_time_slot

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

  private

  def unique_played_on_and_time_slot
    game_exists = Game.where(played_on: played_on, time_slot: time_slot).exists?

    return unless game_exists

    error_args = [:played_on, 'game exists for same date and time slot']

    errors.add(*error_args)
  end
end
