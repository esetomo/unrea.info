Unrea::Application.routes.draw do
  resources :posts

  match 'login' => 'users#login'
  match 'callback' => 'users#callback'
  match 'logout' => 'users#logout'

  match ':year/:month/:day/:hour:min:sec' => 'posts#show_by_time', :constraints => {
    :hour => /\d{2}/,
    :min => /\d{2}/,
    :sec => /\d{2}/,
  }
  match ':year' => 'posts#index_by_year'
  match ':year/:month' => 'posts#index_by_month'
  match ':year/:month/:day' => 'posts#index_by_day'

  root :to => "posts#index"
end
