# frozen_string_literal: true

# BillAmount ActiveModel Class
class BillAmount < ApplicationRecord
  belongs_to :bill
  belongs_to :player
  has_secure_token :token

  def notification_message_content
    "Hi #{player.firstname},\n" \
    "Bill for the time period #{bill.strf_date_range} has been generated." \
    "Kindly pay Rs.#{amount}/- to 9633903653@upi\n" \
    "Visit https://localhost:3000/bill_amounts/show/#{token} for more details."
  end
end
