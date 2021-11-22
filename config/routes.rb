Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: "json"} do
    scope module: 'v1' do 
      #match '/auth/login', :controller => 'auth', :action => 'login', :via => :post
      #get '/auth/login', to: 'auth#login'
      #get '/auth/login', action: :login, controller: 'auth'
      #match "/auth/login" => "auth#login", :via => :get, :as => :auth_login
      #post "/auth/login", to: 'auth#login', controller: "Api::V1::AuthController"
      resources :auth do
        collection do
         post 'login'
         post 'create_user'
        end
      end
    end
  end
end
