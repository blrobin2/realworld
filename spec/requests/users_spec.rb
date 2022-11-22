require 'rails_helper'

RSpec.describe 'Users' do
  # describe "GET /users" do
  #   it "works! (now write some real specs)" do
  #     get users_index_path
  #     expect(response).to have_http_status(200)
  #   end
  # end

  describe 'get current user' do
    let(:user) { create(:user) }
    let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }

    it 'fetches the user currently logged in' do
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)

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
end
