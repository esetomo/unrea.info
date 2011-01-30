Unrea::Application.routes.draw do
  resource :user_session do
    get :create
  end

  root :to => "welcome#index"
end
