# frozen_string_literal: true

# Nofifier module
module Notifier
  # SMS Notifier
  module SMS
    def self.send(msisdn, text)
      requested_url = 'https://api.textlocal.in/send/?'
      uri = URI.parse(requested_url)

      res = Net::HTTP.post_form(
        uri,
        'apikey' => 'd8CfZ16D37Q-1T9eeakezVs2yLFiKHsstp7amDwlyZ',
        'message' => text,
        'sender' => 'TXTLCL',
        'numbers' => "91#{msisdn}"
      )

      JSON.parse(res.body)
    end
  end
end
