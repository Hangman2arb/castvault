require 'sidekiq/web'
Rails.application.routes.draw do

  match '/500', via: :all, to: 'errors#internal_server_error'
  match '/404', via: :all, to: 'errors#not_found'

  devise_for :users, :controllers => {registrations: 'registrations', sessions: 'sessions', confirmations: 'confirmations', passwords: 'passwords'}

  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # Web for LetterOpener (only DEV)
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root "home#index"

  namespace :manager do
    root 'dashboard#index', menu_option_id: 'dashboard'
    resources :profiles, only: [:index, :create, :edit, :update, :destroy, :show], menu_option_id: 'profiles'
    resources :forms, menu_option_id: 'forms' do
      get 'search_languages', to: 'forms#search_languages'
      get 'search_available_for', to: 'forms#search_available_for'
    end
    resources :instructions, only: [:index], menu_option_id: 'instructions'
  end
end
