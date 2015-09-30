require 'services/models/webhose/search'

module Services
  module Responses
    module Webhose
      class Search
        attr_accessor :response, :models

        def initialize(response)
          @response = response
          @models = extract_models
        end

        def extract_models
          Services::Models::Webhose::Search.new(response)
        end
      end
    end
  end
end
