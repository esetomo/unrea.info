Unrea::Application.routes.draw do
  resource :account, :controller => "users"
  resources :users
  resource :user_session

  resource :oauth do
    member do
      get 'verify'
      get 'callback'
    end
  end

  root :to => "welcome#index"
end
