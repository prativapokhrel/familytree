require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'api/v1/users#index'

  namespace :api do 
    namespace :v1 do 
      resources :users 
    end 
  end 
  
  mount Sidekiq::Web => '/sidekiq'
end



