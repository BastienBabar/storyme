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
            token: '0a8b5e5c-5654-4f2e-9beb-bcd9ccabb19d', #ENV['token_webhose']
            format: 'json',
            q: 'obama', #request.query
            site_type: 'news', #request.type
            performance_score: '5', #request.perf_score
        }.to_query
      end
    end
  end
end