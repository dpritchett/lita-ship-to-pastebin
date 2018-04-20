require 'pry'
require 'faraday'

module Lita
  module Extensions
    class ShipToPastebin
      PASTEBIN_API_KEY = 'd88582e90ba06b60569dc55ab5b678ce'
      PASTEBIN_URL = 'https://pastebin.com/api/api_post.php'

      def hi(name)
        name
      end

      def do_a_barrel_roll
        name = 'slippy'

        begin
          result = Faraday.post PASTEBIN_URL, {
            api_dev_key: PASTEBIN_API_KEY,
            api_paste_name: 'john dot mem',
            api_paste_code: 'just call me the body oh em jeez',
            api_option: 'paste',
          }
        rescue Faraday::Error => err
          raise ConnectionError, err.message
        end

        # plz notice me rake
        binding.pry

        parsed = JSON.parse(result.body)

        if parsed.keys.include?('error_message')
          raise(ImgflipApiError, parsed['error_message'])
        end

        image = parsed.fetch('data', {}).fetch('url')
      end
    end
  end
end
