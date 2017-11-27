require 'rails_helper'

RSpec.describe 'Marketplace API', type: :request do
  # initialize test data 
  let!(:bids) { create_list(:bid, 2) }
  let(:bid_id) { bids.first.id }

  # Test suite for GET /bids
  describe 'GET /bids' do
    # make HTTP get request before each example
    before { get '/bids' }

    it 'returns bids' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /bids/:id
  describe 'GET /bids/:id' do
    before { get "/bids/#{bid_id}" }

    context 'when the record exists' do
      it 'returns the bid' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(bid_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:bid_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Bid/)
      end
    end
  end

  # Test suite for POST /bids
  describe 'POST /bids' do
    # valid payload
    let(:valid_attributes) { { rate: 10.12, buyer_id: '2', project_id: '1'} }

    context 'when the request is valid' do
      before { post '/bids', params: valid_attributes }

      it 'creates a bid' do
        expect(json['rate']).to eq(10.12)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/bids', params: {rate: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Buyer must exist, Project must exist/)
      end
    end
  end

  # Test suite for DELETE /bids/:id
  describe 'DELETE /bids/:id' do
    before { delete "/bids/#{bid_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
