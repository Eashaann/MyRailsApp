Rails.application.routes.draw do
  devise_for :users,:path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout',:sign_up => 'register'}
  resources :products, :users
  
  get 'about', to: 'static_pages#about'

  get 'contact', to: 'static_pages#contact'

  # get 'welcome' , to: 'static_pages#index'
  
  get 'featured', to:'static_pages#landing_page'

  # root 'products#index'

  root 'static_pages#index'

  post 'static_pages/thank_you'

  resources :orders, only: [:index, :show, :create, :destroy] 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


