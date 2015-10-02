require 'rails_helper'

describe Services::Responses::Webhose::Search do
  context '#models' do
    let(:response) { double(body: webhose_search_response) }
    let(:models) { Services::Responses::Webhose::Search.new(response).models }

    it { expect(models.nil?).to eq false }

    it 'return the Webhose::Search model' do
      models.each { |model|
        expect(model).to be_a Services::Models::Webhose::Search
      }
    end
  end
end
