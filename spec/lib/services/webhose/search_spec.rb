require 'rails_helper'
require 'services/webhose/search'

describe Services::Webhose::Search do
  let(:service) { Services::Webhose::Search.new(request) }
  let(:query_params) do
    {
        token: ENV['TOKEN_WEBHOSE'],
        format: 'json',
        q: 'obama',
        site_type: 'news',
        performance_score: '5'
    }
  end
  let(:response) { webhose_search_response }
  let(:base_url) { 'https://webhose.io/search?' }
  let(:subject) { service.get }
  before do
    allow(HTTParty).to receive(:get).and_return(response)
  end

  describe '#get' do
    let(:request) { Services::Requests::Webhose::Search.new('obama', 'news', '5') }

    context do
      it 'creates an array of Search model' do
        expect(subject).to be_an Array

        subject.each do |response|
          expect(response).to be_a Services::Models::Webhose::Search
        end
      end

      after { subject }

      it 'calls the GET url with a query'  do
        uri = base_url + query_params.to_query
        expect(HTTParty).to receive(:get).with(uri)
      end
    end
  end
end