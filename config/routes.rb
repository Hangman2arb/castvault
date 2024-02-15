require 'sidekiq/web'
Rails.application.routes.draw do

  match '/500', via: :all, to: 'errors#internal_server_error'
  match '/404', via: :all, to: 'errors#not_found'

  devise_for :users, :controllers => {registrations: 'registrations', sessions: 'sessions', confirmations: 'confirmations', passwords: 'passwords'}

  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root "home#index"
end
