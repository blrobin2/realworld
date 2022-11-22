class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_profile

  def show; end

  def follow
    follow = Follow.new(follower: current_user, followed: @profile)
    respond_to do |format|
      if follow.save
        format.json { render :show, status: :ok, location: @profile }
      else
        format.json { render json: follow.errors, status: :unprocessable_entity }
      end
    end
  end

  def unfollow; end

  private

  def set_profile
    @profile = User.find_by(username: profile_params)
  end

  def profile_params
    params.require(:username)
  end
end
