require 'rails_helper'

RSpec.describe 'Tags' do
  let(:user) { create(:user) }
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, user) }

  describe 'get all tags' do
    it 'can fetch all of the tags' do
      tags = create_list(:tag, 3)
      get tags_path, headers: auth_headers
      tag_response = response.parsed_body

      expect(tag_response['tags']).to contain_exactly(*tags.pluck(:name))
    end

    it 'does not require authentication' do
      tags = create_list(:tag, 3)
      get tags_path, headers: headers
      tag_response = response.parsed_body

      expect(tag_response['tags']).to contain_exactly(*tags.pluck(:name))
    end
  end
end
