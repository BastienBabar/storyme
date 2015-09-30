module Services
  module Models
    module Webhose
      class Search
        attr_reader :result
        class Item < Struct.new(:id, :url, :ord_in_thread, :title, :text); end

        def initialize(args = {})
          @result = create(args)
        end

        private
        def create(args)
          (args || []).map do |item|
            Item.new(item['uuid'], item['url'], item['ord_in_thread'],
                     item['title'], item['text'])
          end
        end
      end
    end
  end
end