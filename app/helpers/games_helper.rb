# frozen_string_literal: true

# Helper methods for Games
module GamesHelper
  def time_slots
    [['8 PM', 2000], ['7 PM', 1900], ['6 PM', 1800]]
  end

  def durations
    [['1 hour', 1], ['2 hours', 2]]
  end

  def parse_time_slot(time_slot)
    hour = time_slot / 100
    minutes = (time_slot % 100).to_s.ljust(2, '0')

    return "#{hour - 12}:#{minutes} PM" if hour >= 12

    "#{hour}:#{minutes} AM"
  end

  def parse_date(date)
    date&.strftime('%d %b %Y')
  end

  def parse_duration(duration)
    unit = duration > 1 ? 'hours' : 'hour'

    "#{duration} #{unit}"
  end
end
