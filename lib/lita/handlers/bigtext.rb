require 'lita-ship-to-pastebin'

module Lita
  module Handlers
    class Bigtext < Handler
      config :pastebin_api_key, default: 'd88582e90ba06b60569dc55ab5b678ce'

      Lita.register_handler(self)

      # START:snip
      route(/^bigtext/i,
            :hide_bigtext,
            command: true,
            help: {
              'bigtext' => 'gimme a wall of text hidden behind a pastebin URL'
            })

      def hide_bigtext(message)
        message.reply longtext
      end

      def snip_text(text)
        Lita::Extensions::ShipToPastebin.new.save_to_pastebin(text, api_key: config.pastebin_api_key)
      end

      def longtext
        (1..100).each.map do
          %w[able baker charlie delta echo alpha bravo hawaii].sample
        end.join(' ')
      end
      # END:snip
    end
  end
end
