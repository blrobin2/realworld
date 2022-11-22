class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def show
    @profile = User.find_by(username: profile_params)
  end

  def follow; end

  def unfollow; end

  private

  def profile_params
    params.require(:username)
  end
end
