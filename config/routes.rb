Unrea::Application.routes.draw do
  resource :oauth do
    member do
      get 'verify'
      get 'callback'
    end
  end

  root :to => "welcome#index"
end
