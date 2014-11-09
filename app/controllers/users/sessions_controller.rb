class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource_or_scope)
    user_path(resource_or_scope.id)
  end
end