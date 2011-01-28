Unrea::Application.routes.draw do
  resource :user_session do
    member do
      get 'create'
    end
  end

  resource :oauth do
    member do
      get 'verify'
      get 'callback'
    end
  end

  root :to => "welcome#index"
end
