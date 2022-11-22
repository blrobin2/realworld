class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Denylist

  attr_accessor :token

  def on_jwt_dispatch(token, _payload)
    self.token = token
  end
end
