require 'services/models/webhose/search'

module Services
  module Responses
    module Webhose
      class Search
        attr_accessor :response, :models

        def initialize(response)
          @response = response.body
          @models = extract_models
        end

        def extract_models
          (parsed_response['posts'] || []).map do |post|
            Services::Models::Webhose::Search.new(post)
          end
        end

        def parsed_response
          JSON.parse response unless response.nil?
        end
      end
    end
  end
end
