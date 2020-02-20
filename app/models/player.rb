class Player < ApplicationRecord
  has_and_belongs_to_many :games
  has_many :bill_amounts

  def fullname
    "#{firstname} #{lastname}"
  end

  def games_count
    game_ids.count
  end
end
