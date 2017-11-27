require 'rails_helper'

RSpec.describe 'Marketplace API', type: :request do
  # initialize test data 
  describe 'GET /does_not_exist ' do
    # make HTTP get request before each example
    before { get '/does_not_exist' }

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end

  end
end

