require 'lita-ship-to-pastebin'

module Lita
  module Handlers
    class Bigtext < Handler
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
        Lita::Extensions::ShipToPastebin.new.save_to_pastebin(text)
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
