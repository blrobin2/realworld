class UsersController < ApplicationController
  def show; end

  def update
    user = current_user
    respond_to do |format|
      if user.update(user_params)
        format.json { render :show, status: :ok, location: user }
      else
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:bio, :email, :image, :username, :password)
  end
end
