require 'rails_helper'

RSpec.describe 'Registrations' do
  before do
    stub_const('CONTENT_TYPE', 'application/json; charset=utf-8')
  end

  describe 'valid registration' do
    let(:user) { build(:user) }

    before { signup(user) }

    specify { expect(response.headers['Content-Type']).to eq(CONTENT_TYPE) }

    it 'registers a valid user' do
      user_response = response.parsed_body

      expect(User.new(user_response['user'])).to have_attributes(
        email: user.email,
        token: an_instance_of(String),
        username: user.username,
        bio: an_instance_of(String),
        image: user.image
      )
    end
  end

  describe 'missing email' do
    let(:user) { User.new }

    before { signup(user) }

    specify { expect(response.headers['Content-Type']).to eq(CONTENT_TYPE) }
    specify { expect(response).to have_http_status(:unprocessable_entity) }

    it 'does not create user missing email' do
      expect(response.parsed_body).to eq(
        'errors' => {
          'email' => ["can't be blank"],
          'password' => ["can't be blank"],
          'username' => ["can't be blank"]
        }
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
