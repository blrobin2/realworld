require 'rails_helper'

RSpec.describe 'Users' do
  let(:user) { create(:user) }
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, user) }

  describe 'get current user' do
    it 'fetches the user currently logged in' do
      get '/api/user', headers: auth_headers

      user_response = response.parsed_body

      expect(User.new(user_response['user'])).to have_attributes(
        email: user.email,
        username: user.username,
        bio: user.bio,
        image: user.image
      )
    end

    it 'must receive auth headers' do
      get '/api/user', headers: headers

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'update current user' do
    let(:user_body) do
      {
        user: {
          email: 'jake@jake.jake',
          bio: 'I like to skateboard',
          image: 'https://i.stack.imgur.com/xHWG8.jpg'
        }
      }
    end

    it 'updates the user currently logged in' do
      put '/api/user', headers: auth_headers, params: JSON.dump(user_body)

      user_response = response.parsed_body

      expect(User.new(user_response['user'])).to have_attributes(
        email: user_body[:user][:email],
        username: user.username,
        bio: user_body[:user][:bio],
        image: user_body[:user][:image]
      )
    end

    it 'must receive auth headers' do
      put '/api/user', headers: headers, params: JSON.dump(user_body)

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
