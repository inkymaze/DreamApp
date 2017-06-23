Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  #resources :dreams
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
