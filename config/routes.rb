Unrea::Application.routes.draw do
  controller :users do
    match 'login'
    match 'callback'
    match 'logout'
    match 'u/:screen_name', :action => :show, :as => :user
  end

  controller :user_appearances do
    get 'u/:screen_name/a', :action => :index, :as => :user_appearances
    get 'u/:screen_name/a/new', :action => :new, :as => :new_user_appearance
    get 'u/:screen_name/a/:id', :action => :show, :as => :user_appearance
    get 'u/:screen_name/a/:id/edit', :action => :edit, :as => :edit_user_appearance
    post 'u/:screen_name/a', :action => :create
    put 'u/:screen_name/a/:id', :action => :update
    delete 'u/:screen_name/a/:id', :action => :destroy
  end

  resources :appearances do
    get 'edit/:key', :action => :edit, :as => :edit
  end

  root :to => "welcome#index"
end
