class Player < ApplicationRecord
  has_and_belongs_to_many :games
  has_many :bill_amounts

  before_save { self.email_id = email_id.downcase }
  validates :firstname, presence: true, length: { maximum: 50 }
  validates :lastname, length: { maximum: 50 }

  VALID_MOBILE_NUMBER_REGEX = /\A\d{10}\z/i.freeze

  validates :mobile_number, presence: true,
                            format: { with: VALID_MOBILE_NUMBER_REGEX },
                            uniqueness: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email_id, presence: true,
                       length: { maximum: 255 },
                       format: { with: VALID_EMAIL_REGEX },
                       uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def fullname
    "#{firstname} #{lastname}"
  end

  def games_count
    game_ids.count
  end

  def self.inactive_players
    Player.where(activated: false)
  end
end
