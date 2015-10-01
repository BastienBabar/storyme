module Services
  module Models
    module Webhose
      class Search
        attr_reader :result
        class Item < Struct.new(:id, :url, :ord_in_thread, :title, :text); end

        def initialize(args)
          @result = Item.new(args['uuid'], args['url'], args['ord_in_thread'].to_i, args['title'], args['text'])
        end
      end
    end
  end
end