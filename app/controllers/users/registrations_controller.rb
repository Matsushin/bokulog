class Users::RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    users_path
  end

  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end

  def create
    super do |resource|
      User.find(resource.id).build_bookshelf.save if User.exists?(:id => resource.id)
    end
  end
end