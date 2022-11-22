require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'valid registration' do
    let(:user) { build(:user) }

    before { signup(user) }

    it 'registers a valid user' do
      user_response = response.parsed_body

      expect(User.new(user_response['user'])).to have_attributes(
        email: user.email,
        token: an_instance_of(String),
        username: user.username,
        image: user.image
      )
    end
  end

  def signup(user)
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    user_params = {
      user: {
        email: user.email,
        password: user.password,
        username: user.username
      }
    }

    post '/api/users', params: JSON.dump(user_params), headers: headers
  end
end
