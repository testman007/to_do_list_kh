Rails.application.routes.draw do
  root "lists#index"

  # resources :lists
  resources :lists do
    member do
      post :is_done
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
