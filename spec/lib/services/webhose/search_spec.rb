require 'rails_helper'
require 'services/webhose/search'

describe Services::Webhose::Search do
  let(:service) { Services::Webhose::Search.new(request) }
  let(:subject) { service.get }

  describe '#get' do
    let(:request) { Services::Requests::Webhose::Search.new('obama', 'news', '5') }
    let(:base_url) { 'https://webhose.io/search?' }
    let(:request_params) { { format: 'json',  performance_score: request.perf_score, site_type: request.type, q: request.query, token: ENV['TOKEN_WEBHOSE'] } }

    let(:args)  { { skilldid: '1234', confidence: '1', normalized_term: 'Front end developer' } }
    let(:response) { double(body: webhose_search_response, models: mock_webhose_search_response) }

    before do
      allow(Services::Responses::Webhose::Search).to receive(:new).and_return(response)
    end

    context do
      it 'creates an array of Webhose::Search model' do
        expect(subject).to be_an Array

        subject.each do |response|
          expect(response).to be_a Services::Models::Webhose::Search
        end
      end

      after { subject }

      it 'calls the GET url with a query'  do
        uri = base_url + request_params.to_query
        expect(HTTParty).to receive(:get).with(uri)
      end
    end
  end
end
