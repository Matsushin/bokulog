class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_user

  def facebook
    connect_oauth_account
  end

  def twitter
    connect_oauth_account
  end

  def github
    connect_oauth_account
  end

  private

  def set_user
    auth = request.env["omniauth.auth"]
    @user = User.find_or_create_by_oauth(auth)
  end

  def connect_oauth_account
    auth = request.env["omniauth.auth"].extra("extra")
    unless current_user
      if @user.persisted?
        if @user.bookshelf.nil?
          @user.build_bookshelf.save
        end
        set_flash_message(:notice, :success, :kind => auth.provider) if is_navigational_format?
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.omniauth_data"] = auth
        redirect_to new_user_registration_url
      end
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    users_path
  end
end