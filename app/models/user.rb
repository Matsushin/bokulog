class User < ActiveRecord::Base
  has_many :items
  has_many :books, through: :items
  validates :username, :email, :encrypted_password, presence: true
  validates :username, :email, :uid, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.find_or_create_by_oauth(auth)
    user = self.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = self.create(self.build_oauth_user(auth))
    end
    user
  end

  def self.build_oauth_user(auth)
    user_data = {
        :provider => auth.provider,
        :uid      => auth.uid,
        :password =>  Devise.friendly_token[0,20]
    }

    case auth.provider
      when "facebook" then
        user_data[:username]  = auth.extra.raw_info.name
        user_data[:email] = auth.info.email
        user_data[:icon]  = auth.info.image
      when "twitter" then
        user_data[:username]  = auth.info.nickname
        user_data[:email] = self.create_unique_email
        user_data[:icon]  = auth.info.image
      when "github" then
        user_data[:username]  = auth.extra.raw_info.name
        user_data[:email] = auth.info.email
        user_data[:icon]  = auth.extra.raw_info.avatar_url
    end
    user_data
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.create_unique_email
    self.create_unique_string + "@example.com"
  end
end
