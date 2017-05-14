Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'lotto', to: 'lotto#index'
  post 'lotto', to: 'lotto#check'
end
