Unrea::Application.routes.draw do
  controller :users do
    match 'login'
    match 'callback'
    match 'logout'
    match 'u/:screen_name', :action => :show, :as => :user
  end

  controller :appearances do
    match 'render'
  end

  root :to => "welcome#index"
end
