require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
  let(:user) { create(:user) }
  let(:invalid_user) { build(:user) }

  it 'logs in a valid user' do
    login(user)
    user_response = response.parsed_body

    expect(User.new(user_response['user'])).to have_attributes(
      email: user.email,
      token: an_instance_of(String),
      username: user.username,
      bio: user.bio,
      image: user.image
    )
  end

  it 'does not log in an invalid user' do
    login(invalid_user)

    expect(response).to have_http_status(:unauthorized)
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
