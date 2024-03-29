class InvitationsController < Devise::InvitationsController
  layout 'web'

  protected

  def after_accept_path_for(resource)
    manager_root_path
  end
end