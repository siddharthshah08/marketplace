require 'rails_helper'

RSpec.describe 'Marketplace API', type: :request do
  # initialize test data 
  let!(:buyers) { create_list(:buyer, 2) }
  let(:buyer_id) { buyers.first.id }

  # Test suite for GET /buyers
  describe 'GET /buyers' do
    # make HTTP get request before each example
    before { get '/buyers' }

    it 'returns buyers' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /buyers/:id
  describe 'GET /buyers/:id' do
    before { get "/buyers/#{buyer_id}" }

    context 'when the record exists' do
      it 'returns the buyer' do
        #puts "json : #{json}"
	expect(json).not_to be_empty
        expect(json['id']).to eq(buyer_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:buyer_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Buyer/)
      end
    end
  end

  # Test suite for POST /buyers
  describe 'POST /buyers' do
    # valid payload
    let(:valid_attributes) { { uname: 'Lorem Elm', email: 'test@spec.com', password: 'simple1234' }  }

    context 'when the request is valid' do
      before { post '/buyers', params: valid_attributes }

      it 'creates a buyer' do
        expect(json['uname']).to eq('Lorem Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/buyers', params: {  email: 'buyer@spec.com' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Uname can't be blank/)
      end
    end
    
    context 'when uname is same' do
      before { post '/buyers', params: valid_attributes }
      before { post '/buyers', params: valid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Uname has already been taken/)
      end
    end
  end

  # Test suite for PUT /buyers/:id
  describe 'PUT /buyers/:id' do
    let(:valid_attributes) { { email: 'buyer@spec.com'} }

    context 'when the record exists' do
      before { put "/buyers/#{buyer_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
   
    context 'when the record does not exist' do
      before { put "/buyers/1111" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Buyer/)
      end
    end

  end

  # Test suite for DELETE /buyers/:id
  describe 'DELETE /buyers/:id' do
    before { delete "/buyers/#{buyer_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
