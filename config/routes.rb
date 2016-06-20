Rails.application.routes.draw do
  resources :profiles
  root 'profiles#new'
end
