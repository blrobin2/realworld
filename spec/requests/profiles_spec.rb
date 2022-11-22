require 'rails_helper'

RSpec.describe 'Profiles' do
  let(:users) { create_list(:user, 3) }
  let(:user) { users[0] }
  let(:other) { users[1] }
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, user) }

  describe 'find by username' do
    it 'can find a user by their username' do
      get "/api/profiles/#{other.username}", headers: auth_headers

      user_response = response.parsed_body

      expect(user_response['profile']).to eq(
        {
          'username' => other.username,
          'bio' => other.bio,
          'image' => other.image,
          'following' => false
        }
      )
    end

    it 'can find a user without authenticating' do
      get "/api/profiles/#{other.username}", headers: headers

      user_response = response.parsed_body

      expect(user_response['profile']).to eq(
        {
          'username' => other.username,
          'bio' => other.bio,
          'image' => other.image,
          'following' => false
        }
      )
    end
  end
end
