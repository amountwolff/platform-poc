User::Engine.routes.draw do
  resources :customers

  get 'profile', to: 'accounts#show', as: :profile

  devise_for :accounts, class_name: "User::Account", module: :devise, :skip => [:sessions, :registrations], controllers: {
      sessions: 'user/sessions'
    }

  devise_scope :account do
    get 'sign_in', to: 'sessions#new', as: :new_account_session
    post 'sign_in', to: 'sessions#create', as: :account_session
    get 'email_confirmation', to: 'sessions#email_confirmation', as: :email_confirmation
  end

  #mount User::API => '/'
end
