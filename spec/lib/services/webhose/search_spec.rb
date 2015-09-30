require 'rails_helper'
require 'services/webhose/search'

describe Services::Webhose::Search do
  let(:request) { Services::Requests::Webhose::Search.new('Obama', 'news', '>5') }
  let(:service) { Services::Webhose::Search.new(:request) }
  let(:query_params) do
    {
        token: '0a8b5e5c-5654-4f2e-9beb-bcd9ccabb19d', #ENV['token_webhose']
        format: 'json',
        q: 'obama', #request.query
        site_type: 'news', #request.type
        performance_score: '>5', #request.perf_score
    }
  end
  let(:response) { skill_by_title_response }
  let(:base_url) { 'https://biapi.cb.com/v3/skillsbytitle?' }
  before do
    allow(HTTParty).to receive(:get).and_return(response)
  end

  describe '#get' do
      let(:subject) { service.get }

      context do
        after { subject }

        it 'calls the GET url with a query'  do
          uri = base_url + query_params.to_query
          expect(HTTParty).to receive(:get).with(uri)
        end

        it 'call generate on the converters' do
          expect_any_instance_of(Services::Converters::SkillByTitle).to receive(:generate)
        end

        it 'converts and returns the calculated model' do
          subject.each do |response|
            if response.set == 2
              expect(response).to be_a Services::Converters::SkillByTitle::JobSkills
            elsif response.set == 1
              expect(response).to be_a Services::Converters::SkillByTitle::JobResumeSkills
            elsif response.set == 0
              expect(response).to be_a Services::Converters::SkillByTitle::ResumeSkills
            end
          end
        end
      end

      context 'when no data found' do
        let(:response) { skill_by_title_no_response }

        it do
          expect(subject).to eq []
        end
      end

    end
end