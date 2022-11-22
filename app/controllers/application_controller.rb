# frozen_string_literal: true

class ApplicationController < ActionController::Base
  respond_to :json
  skip_before_action :verify_authenticity_token, if: :json_request?

  def json_request?
    request.format.json?
  end
end
