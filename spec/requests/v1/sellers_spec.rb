require 'rails_helper'

RSpec.describe 'Sellers API', type: :request do
  # initialize test data 
  let!(:sellers) { create_list(:seller, 2) }
  let(:seller_id) { sellers.first.id }

  # Test suite for GET /sellers
  describe 'GET /sellers' do
    # make HTTP get request before each example
    before { get '/sellers' }

    it 'returns sellers' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /sellers/:id
  describe 'GET /sellers/:id' do
    before { get "/sellers/#{seller_id}" }

    context 'when the record exists' do
      it 'returns the seller' do
	expect(json).not_to be_empty
        expect(json['id']).to eq(seller_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:seller_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Seller/)
      end
    end
  end

  # Test suite for POST /sellers
  describe 'POST /sellers' do
    # valid payload
    let(:valid_attributes) { { uname: 'Learn Elm', email: 'test@spec.com', password: 'simple1234' } }

    context 'when uname is same' do
      before { post '/sellers', params: valid_attributes }
      before { post '/sellers', params: valid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      
      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Uname has already been taken/)
      end
    end

    context 'when the request is valid' do
      before { post '/sellers', params: valid_attributes }

      it 'creates a seller' do
        expect(json['uname']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/sellers', params: { email: 'test@spec.com' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Uname can't be blank/)
      end
    end
  end

  # Test suite for PUT /sellers/:id
  describe 'PUT /sellers/:id' do
    let(:valid_attributes) { {uname: 'Learn Elm' } }

    context 'when the record exists' do
      before { put "/sellers/#{seller_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exist' do
      before { put "/sellers/1000" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Seller/)
      end
    end

  end

  # Test suite for DELETE /sellers/:id
  describe 'DELETE /sellers/:id' do
    before { delete "/sellers/#{seller_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
