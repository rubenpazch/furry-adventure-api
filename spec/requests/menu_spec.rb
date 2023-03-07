# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Menus', type: :request do
  describe 'GET /index' do
    skip 'returns http success' do
      get '/menu/index'
      expect(response).to have_http_status(:success)
    end
  end
end
