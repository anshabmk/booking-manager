# frozen_string_literal: true

# Helper methods for Games
module GamesHelper
  def games_index_header_names
    ['Played on', 'Time slot', 'Duration', 'No. of players']
  end

  def games_index_header_methods
    %w[parsed_played_on_date parsed_time_slot parsed_duration players_count]
  end

  def time_slots
    [['8 PM', 2000], ['7 PM', 1900], ['6 PM', 1800]]
  end

  def durations
    [['1 hour', 1], ['2 hours', 2]]
  end
end
