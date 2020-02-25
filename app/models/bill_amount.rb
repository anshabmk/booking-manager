# frozen_string_literal: true

# BillAmount ActiveModel Class
class BillAmount < ApplicationRecord
  belongs_to :bill
  belongs_to :player
  has_secure_token :token

  def notification_message_content
    "Pay Rs.#{amount}/- to 9633903653@upi %n" \
    "Click #{ENV['APPLICATION_URL']}/bill_amounts/show/#{token} for more."
  end
end
