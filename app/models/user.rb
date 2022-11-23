class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenyList

  validates :username, presence: true

  has_many :active_follows, class_name: 'Follow',
                            foreign_key: :follower_id,
                            dependent: :destroy,
                            inverse_of: :follower
  has_many :followings, through: :active_follows, source: :followed
  has_many :passive_follows, class_name: 'Follow',
                             foreign_key: :followed_id,
                             dependent: :destroy,
                             inverse_of: :followed
  has_many :followers, through: :passive_follows, source: :follower

  attr_accessor :token

  def on_jwt_dispatch(token, _payload)
    self.token = token
  end

  def following?(user)
    followings.include?(user)
  end

  def to_param
    username.to_s.parameterize
  end
end
