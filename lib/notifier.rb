# frozen_string_literal: true

# Nofifier module
module Notifier
  # SMS Notifier
  module SMS
    def self.send(msisdn, text)
      uri = URI.parse(ENV['TEXTLOCAL_API_URL'])

      res = Net::HTTP.post_form(
        uri,
        apikey: ENV['TEXTLOCAL_API_KEY'],
        message: text,
        sender: ENV['TEXTLOCAL_SENDER_ID'],
        numbers: "91#{msisdn}",
        test: Rails.env == 'development' ? 'true' : 'false'
      )

      JSON.parse(res.body)
    end
  end
end
