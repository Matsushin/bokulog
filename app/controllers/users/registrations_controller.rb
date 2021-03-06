class Users::RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    user_path(resource.id)
  end

  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end
end