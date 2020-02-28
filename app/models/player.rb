class Player < ApplicationRecord
  attr_accessor :skip_password

  has_and_belongs_to_many :games
  has_many :bill_amounts

  before_save { self.email_id = email_id.downcase }
  validates :firstname, presence: true, length: { maximum: 50 }
  validates :lastname, length: { maximum: 50 }

  VALID_MOBILE_NUMBER_REGEX = /\A\d{10}\z/i.freeze

  validates :mobile_number, presence: true,
                            format: { with: VALID_MOBILE_NUMBER_REGEX }

  validate :unique_mobile_number

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email_id, presence: true,
                       length: { maximum: 255 },
                       format: { with: VALID_EMAIL_REGEX },
                       uniqueness: { case_sensitive: false }

  has_secure_password

  validates :password, presence: true,
                       length: { minimum: 6 },
                       unless: :skip_password

  def fullname
    "#{firstname} #{lastname}"
  end

  def games_count
    game_ids.count
  end

  def self.inactive_players
    Player.where(activated: false)
  end

  private

  def unique_mobile_number
    return unless mobile_number_changed?

    active_mobile_numbers = Player.where(activated: true).pluck(:mobile_number)
    error_args = [:mobile_number, 'is already taken']

    errors.add(*error_args) if active_mobile_numbers.include?(mobile_number)
  end
end
