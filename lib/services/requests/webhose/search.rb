module Services
  module Requests
    module Webhose
      class Search < Struct.new(:query, :type, :perf_score)
      end
    end
  end
end
