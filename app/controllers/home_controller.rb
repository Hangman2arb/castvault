class HomeController < ApplicationController
  layout 'web'
  def index
    @feature_icons = {
      'customization' => 'bi-toggles',
      'media_uploads' => 'bi-camera',
      'diversity_options' => 'bi-people',
      'accessibility' => 'bi-person-check',
      'dynamic_fields' => 'bi-pencil-square',
      'profile_management' => 'bi-person-lines-fill',
    }
  end
end
