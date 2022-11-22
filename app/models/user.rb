class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenyList

  validates :username, presence: true

  attr_accessor :token

  def on_jwt_dispatch(token, _payload)
    self.token = token
  end

  def following
    false
  end
end
