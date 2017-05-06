Rails.application.routes.draw do
  devise_for :users,:path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout',:sign_up => 'register'}
  
  resources :products do
    resources :comments
  end

  resources :users
  
  get 'about', to: 'static_pages#about'

  get 'contact', to: 'static_pages#contact'
  
  get 'featured', to:'static_pages#landing_page'

  get 'home', to: 'static_pages#home'

  root 'static_pages#index'

  post 'static_pages/thank_you'

  resources :orders, only: [:index, :show, :create, :destroy] 

  post 'payments/create', to:'payments#create'

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


