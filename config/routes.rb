Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
    }
  root 'home#index'
  
  resources :allotments do
    member do
      get 'deallot'
    end
  end

  resources :brands
  resources :categories

  resources :items do
    member do
      get 'allotments'
      get 'managestock', to: 'items#manage_item_stock'
      patch 'updatestock', to: 'items#update_stock'
    end
  end

end
