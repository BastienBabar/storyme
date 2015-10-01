require 'services/responses/webhose/search'

module Services
  module Webhose
    class Search
      attr_reader :request

      def initialize(request)
        @request = request
      end

      def get
        response  = HTTParty.get(base_uri)
        Services::Responses::Webhose::Search.new(response).models
      end

      private

      def base_uri
        "https://webhose.io/search?#{request_hash}"
      end

      def request_hash
        {
            token: ENV['TOKEN_WEBHOSE'],
            format: 'json',
            q: request.query,
            site_type: request.type,
            performance_score: request.perf_score,
        }.to_query
      end
    end
  end
end