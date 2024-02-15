class ApplicationController < ActionController::Base
  include Language
  include DeviseCustomParameters
  include Pagy::Backend
  include Utilities
  include ApplicationHelper
end
