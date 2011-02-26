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

  controller :appearances do
    get "appearances/:command.jpg", :action => :image, :as => :appearance_image
  end

  resources :appearances do
    member do
      get 'edit/:key', :action => :edit, :as => :edit
      post 'add_item/:item_id', :action => :add_item, :as => :add_item_to
      post "remove_item/:item_id", :action => :remove_item, :as => :remove_item_from
    end
  end

  root :to => "welcome#index"
end
