# frozen_string_literal: true

# Helper methods for Games
module GamesHelper
  def time_slots
    [['8 PM', 2000], ['7 PM', 1900], ['6 PM', 1800]]
  end

  def durations
    [['1 hour', 1], ['2 hours', 2]]
  end
end
