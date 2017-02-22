Rails.application.routes.draw do
  resources :products
  get 'about', to: 'static_pages#about'

  get 'contact', to: 'static_pages#contact'

  get 'welcome' , to: 'static_pages#index'
  
  get 'featured', to:'static_pages#landing_page'

  root 'products#index'

  post 'static_pages/thank_you'

  resources :orders, only: [:index, :show, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


