class ErrorsController < ActionController::Base
  layout 'errors'

  # 500 page
  def internal_server_error
    render status: 500
  end

  # 404 page
  def not_found
    render status: 404
  end
end
