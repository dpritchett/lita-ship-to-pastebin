require 'faraday'

module Lita
  module Extensions
    class ShipToPastebin
      API_KEY_DEFAULT = 'd88582e90ba06b60569dc55ab5b678ce'

      PASTEBIN_URL = 'https://pastebin.com/api/api_post.php'.freeze

      PasteBinError = Class.new(StandardError)

      def save_to_pastebin(message, title: "Lita's Wall of Text", api_key: API_KEY_DEFAULT )
        begin
          result = Faraday.post PASTEBIN_URL, {
            api_dev_key: api_key,
            api_paste_name: title,
            api_paste_code: message,
            api_option: 'paste'
          }
        rescue Faraday::Error => err
          raise ConnectionError, err.message
        end

        if !result.success? || result.body.include?('Bad API')
          raise PasteBinError, "Unable to deal with this Faraday response: [#{result.body}]"
        end

        result.body
      end
    end
  end
end
