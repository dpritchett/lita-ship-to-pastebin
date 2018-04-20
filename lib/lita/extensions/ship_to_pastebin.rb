require 'pry'
require 'faraday'

module Lita
  module Extensions
    class ShipToPastebin
      PASTEBIN_API_KEY = 'd88582e90ba06b60569dc55ab5b678ce'
      PASTEBIN_URL = 'https://pastebin.com/api/api_post.php'

      PasteBinError = Class.new(StandardError)

      def hi(name)
        name
      end

      def save_to_pastebin(message, title: "Lita's Wall of Text")
        begin
          result = Faraday.post PASTEBIN_URL, {
            api_dev_key: PASTEBIN_API_KEY,
            api_paste_name: title,
            api_paste_code: message,
            api_option: 'paste'
          }
        rescue Faraday::Error => err
          raise ConnectionError, err.message
        end

        if !result.success? || result.body.include?('Bad API')
          raise PasteBinError, result.body
        end

        result.body
      end
    end
  end
end
