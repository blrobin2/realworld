require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
  before do
    stub_const('CONTENT_TYPE', 'application/json; charset=utf-8')
  end

  describe 'valid login' do
    let(:user) { create(:user) }

    before { login(user) }

    specify { expect(response.headers['Content-Type']).to eq(CONTENT_TYPE) }

    it 'logs in a valid user' do
      user_response = response.parsed_body

      expect(User.new(user_response['user'])).to have_attributes(
        email: user.email,
        token: an_instance_of(String),
        username: user.username,
        bio: user.bio,
        image: user.image
      )
    end
  end

  describe 'invalid login' do
    let(:invalid_user) { build(:user) }

    before { login(invalid_user) }

    specify { expect(response.headers['Content-Type']).to eq(CONTENT_TYPE) }

    it 'does not log in an invalid user' do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  def login(user)
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    user_params = {
      user: {
        email: user.email,
        password: user.password
      }
    }

    post '/api/users/login', params: JSON.dump(user_params), headers: headers
  end
end
