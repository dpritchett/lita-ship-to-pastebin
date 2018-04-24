require 'lita-ship-to-pastebin'

module Lita
  module Handlers
    class Bigtext < Handler
      # insert handler code here

      Lita.register_handler(self)

      # START:snip
      route(/^bigtext/i,
            :hide_bigtext,
            command: true,
            help: {
              'bigtext' => 'gimme a wall of text hidden behind a pastebin URL'
            })

      def hide_bigtext(message)
        binned = longtext

        message.reply binned
      end

      def fakeword
        %w[able baker charlie delta echo alpha bravo hawaii].sample
      end

      def longtext
        words = (1..100).each.map do |n|
          fakeword
        end.join(' ')

        Lita::Extensions::ShipToPastebin.new.save_to_pastebin(words)
      end
      # END:snip
    end
  end
end
