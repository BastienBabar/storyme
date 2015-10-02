module Api
  class SearchController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :null_session

    def get
      @result = Services::Webhose::Search.new(request_search).get
      post = @result.to_a.sample
      render json: post, status: 200
    end

    private

    def request_search
      Services::Requests::Webhose::Search.new(request_params[:q],request_params[:type],request_params[:score])
    end

    def request_params
      {
          q: params[:query],
          type: get_type(params[:type]),
          score: get_score(params[:perf_score])
      }
    end

    def get_type type
      type ? type : WEBHOSE_TYPES[WEBHOSE_TYPES.keys.sample]
    end

    def get_score score
      score ? score : rand(0..10)
    end

  end
end
